import 'package:joojo_chat/core/utils/app_result.dart';
import 'package:joojo_chat/features/onboarding/models/onboarding_step.dart';
import 'package:joojo_chat/features/onboarding/repositories/onboarding_repository.dart';

final class OnboardingService {
  OnboardingService({
    required this._repository,
  });

  final OnboardingRepository _repository;

  List<OnboardingStep> get steps => OnboardingStep.defaultSteps;

  Future<bool> hasCompletedOnboarding() async {
    return await _repository.hasCompletedOnboarding();
  }

  Future<AppResult<void>> completeOnboarding() async {
    return await _repository.setOnboardingCompleted(true);
  }

  Future<AppResult<void>> skipOnboarding() async {
    return await _repository.setOnboardingCompleted(true);
  }

  Future<AppResult<void>> resetOnboarding() async {
    return await _repository.resetOnboarding();
  }
}
