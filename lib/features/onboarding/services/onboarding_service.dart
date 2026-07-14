import 'package:joojo_chat/core/utils/app_result.dart';
import 'package:joojo_chat/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:joojo_chat/features/onboarding/domain/entities/onboarding_step_entity.dart';

final class OnboardingService {
  OnboardingService({
    required this._repository,
  });

  final OnboardingRepository _repository;

  List<OnboardingStepEntity> get steps => OnboardingStepEntity.defaultSteps;

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
