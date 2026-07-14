import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';
import 'package:joojo_chat/core/theme/components/button_theme.dart';
import 'package:joojo_chat/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:joojo_chat/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:joojo_chat/features/onboarding/presentation/widgets/onboarding_step_card.dart';
import 'package:joojo_chat/shared/widgets/app_responsive_constrained_box.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingControllerProvider.notifier).checkOnboardingStatus();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingState state = ref.watch(onboardingControllerProvider);

    if (state.isCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final String route = ref.read(onboardingControllerProvider.notifier).getNextRoute();
        context.go(route);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _buildContent(state),
      ),
    );
  }

  Widget _buildContent(OnboardingState state) {
    if (state.hasError) {
      return _buildErrorState(state.error ?? 'Unknown error');
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              ref.read(onboardingControllerProvider.notifier).goToStep(index);
            },
            itemCount: ref.read(onboardingControllerProvider.notifier).steps.length,
            itemBuilder: (BuildContext context, int index) {
              return OnboardingStepCard(
                step: ref.read(onboardingControllerProvider.notifier).steps[index],
                isVisible: state.currentStepIndex == index,
              );
            },
          ),
        ),
        _buildBottomSection(state),
      ],
    );
  }

  Widget _buildBottomSection(OnboardingState state) {
    final controller = ref.read(onboardingControllerProvider.notifier);
    
    return AppResponsiveConstrainedBox(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            OnboardingPageIndicator(
              currentIndex: state.currentStepIndex,
              totalCount: controller.steps.length,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            _buildActionButtons(state),
            const SizedBox(height: AppSpacing.lg),
            _buildSkipButton(state),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(OnboardingState state) {
    final controller = ref.read(onboardingControllerProvider.notifier);
    final bool isLastStep = state.currentStepIndex == controller.steps.length - 1;

    if (isLastStep) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: state.isLoading ? null : _handleCompleteOnboarding,
          style: AppButtonTheme.light.style,
          child: state.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : const Text('Get Started'),
        ),
      );
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              controller.previousStep();
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            style: AppButtonTheme.outlined.style,
            child: const Text('Back'),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              controller.nextStep();
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            style: AppButtonTheme.light.style,
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }

  Widget _buildSkipButton(OnboardingState state) {
    final controller = ref.read(onboardingControllerProvider.notifier);
    final bool isLastStep = state.currentStepIndex == controller.steps.length - 1;

    if (isLastStep) {
      return const SizedBox.shrink();
    }

    return TextButton(
      onPressed: state.isLoading ? null : _handleSkipOnboarding,
      style: AppButtonTheme.text.style,
      child: const Text('Skip'),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Something went wrong',
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              error,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton(
              onPressed: () {
                ref.read(onboardingControllerProvider.notifier).checkOnboardingStatus();
              },
              style: AppButtonTheme.light.style,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCompleteOnboarding() async {
    final controller = ref.read(onboardingControllerProvider.notifier);
    final result = await controller.completeOnboarding();
    
    if (result.isFailure && mounted) {
      final String errorMessage = result.fold(
        onSuccess: (_) => 'Failed to complete onboarding',
        onFailure: (error, _) => error.toString(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _handleSkipOnboarding() async {
    final controller = ref.read(onboardingControllerProvider.notifier);
    final result = await controller.skipOnboarding();
    
    if (result.isFailure && mounted) {
      final String errorMessage = result.fold(
        onSuccess: (_) => 'Failed to skip onboarding',
        onFailure: (error, _) => error.toString(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
