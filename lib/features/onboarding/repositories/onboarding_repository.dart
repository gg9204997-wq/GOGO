import 'package:joojo_chat/core/services/local_storage_service.dart';
import 'package:joojo_chat/core/services/service_registry.dart';
import 'package:joojo_chat/core/utils/app_result.dart';

final class OnboardingRepository {
  OnboardingRepository({
    LocalStorageService? localStorage,
  }) : _localStorage = localStorage ?? ServiceRegistry.localStorage;

  final LocalStorageService _localStorage;

  static const String _hasCompletedOnboardingKey = 'has_completed_onboarding';

  Future<bool> hasCompletedOnboarding() async {
    try {
      final bool? completed = _localStorage.getBool(_hasCompletedOnboardingKey);
      return completed ?? false;
    } catch (error) {
      return false;
    }
  }

  Future<AppResult<void>> setOnboardingCompleted(bool completed) async {
    try {
      await _localStorage.setBool(_hasCompletedOnboardingKey, completed);
      return const AppSuccess<void>(null);
    } catch (error) {
      return AppFailure<void>(error);
    }
  }

  Future<AppResult<void>> resetOnboarding() async {
    try {
      await _localStorage.remove(_hasCompletedOnboardingKey);
      return const AppSuccess<void>(null);
    } catch (error) {
      return AppFailure<void>(error);
    }
  }
}
