import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';
import 'package:joojo_chat/features/onboarding/models/onboarding_step.dart';

class OnboardingStepCard extends StatelessWidget {
  const OnboardingStepCard({
    required this.step,
    required this.isVisible,
    super.key,
  });

  final OnboardingStep step;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Center(
            child: _buildImage(),
          ),
        ),
        const SizedBox(height: AppSpacing.xxxl),
        Expanded(
          flex: 2,
          child: Padding(
            padding: AppSpacing.page,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTitle(),
                const SizedBox(height: AppSpacing.md),
                _buildDescription(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0x1A6366F1),
            Color(0x1AEC4899),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.chat_bubble_rounded,
          size: 120,
          color: AppColors.primary,
        ),
      ),
    ).animate(target: isVisible ? 1 : 0).fadeIn(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    ).scale(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildTitle() {
    return Text(
      step.title,
      style: AppTextStyles.headlineLarge,
      textAlign: TextAlign.center,
    ).animate(target: isVisible ? 1 : 0).fadeIn(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 200),
    ).slideY(
      begin: 0.3,
      end: 0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  Widget _buildDescription() {
    return Text(
      step.description,
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textSecondary,
      ),
      textAlign: TextAlign.center,
    ).animate(target: isVisible ? 1 : 0).fadeIn(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 400),
    ).slideY(
      begin: 0.3,
      end: 0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }
}
