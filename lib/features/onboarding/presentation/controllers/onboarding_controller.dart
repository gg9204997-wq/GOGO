import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/core/router/app_route_paths.dart';
import 'package:joojo_chat/core/utils/app_result.dart';
import 'package:joojo_chat/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:joojo_chat/features/onboarding/domain/entities/onboarding_step_entity.dart';
import 'package:joojo_chat/features/onboarding/services/onboarding_service.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepository();
});

final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  final OnboardingRepository repository = ref.watch(onboardingRepositoryProvider);
  return OnboardingService(repository: repository);
});

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
  final OnboardingService service = ref.watch(onboardingServiceProvider);
  return OnboardingController(service: service);
});

final class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController({
    required this._service,
  }) : super(const OnboardingState.initial());

  final OnboardingService _service;

  List<OnboardingStepEntity> get steps => _service.steps;

  Future<void> checkOnboardingStatus() async {
    state = const OnboardingState.loading();
    
    final bool hasCompleted = await _service.hasCompletedOnboarding();
    
    state = OnboardingState.loaded(
      hasCompleted: hasCompleted,
      currentStepIndex: 0,
    );
  }

  void nextStep() {
    if (state.currentStepIndex < steps.length - 1) {
      state = state.copyWith(
        currentStepIndex: state.currentStepIndex + 1,
      );
    }
  }

  void previousStep() {
    if (state.currentStepIndex > 0) {
      state = state.copyWith(
        currentStepIndex: state.currentStepIndex - 1,
      );
    }
  }

  void goToStep(int index) {
    if (index >= 0 && index < steps.length) {
      state = state.copyWith(currentStepIndex: index);
    }
  }

  Future<AppResult<void>> completeOnboarding() async {
    state = const OnboardingState.loading();
    
    final AppResult<void> result = await _service.completeOnboarding();
    
    if (result.isSuccess) {
      state = const OnboardingState.completed();
    } else {
      final String errorMessage = result.fold(
        onSuccess: (_) => 'Unknown error',
        onFailure: (error, _) => error.toString(),
      );
      state = OnboardingState.error(errorMessage);
    }
    
    return result;
  }

  Future<AppResult<void>> skipOnboarding() async {
    state = const OnboardingState.loading();
    
    final AppResult<void> result = await _service.skipOnboarding();
    
    if (result.isSuccess) {
      state = const OnboardingState.completed();
    } else {
      final String errorMessage = result.fold(
        onSuccess: (_) => 'Unknown error',
        onFailure: (error, _) => error.toString(),
      );
      state = OnboardingState.error(errorMessage);
    }
    
    return result;
  }

  String getNextRoute() {
    return AppRoutePaths.login;
  }
}

final class OnboardingState {
  const OnboardingState({
    required this.hasCompleted,
    required this.currentStepIndex,
    this.error,
  });

  const OnboardingState.initial()
      : hasCompleted = false,
        currentStepIndex = 0,
        error = null;

  const OnboardingState.loading()
      : hasCompleted = false,
        currentStepIndex = 0,
        error = null;

  const OnboardingState.loaded({
    required this.hasCompleted,
    required this.currentStepIndex,
  }) : error = null;

  const OnboardingState.completed()
      : hasCompleted = true,
        currentStepIndex = 0,
        error = null;

  const OnboardingState.error(this.error)
      : hasCompleted = false,
        currentStepIndex = 0;

  final bool hasCompleted;
  final int currentStepIndex;
  final String? error;

  bool get isLoading => error == null && !hasCompleted && currentStepIndex == 0;
  bool get isLoaded => error == null && !hasCompleted;
  bool get isCompleted => hasCompleted;
  bool get hasError => error != null;

  OnboardingState copyWith({
    bool? hasCompleted,
    int? currentStepIndex,
    String? error,
  }) {
    return OnboardingState(
      hasCompleted: hasCompleted ?? this.hasCompleted,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      error: error ?? this.error,
    );
  }
}
