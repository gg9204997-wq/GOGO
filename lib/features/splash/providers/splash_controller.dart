import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/core/router/app_route_paths.dart';
import 'package:joojo_chat/features/onboarding/repositories/onboarding_repository.dart';
import 'package:joojo_chat/features/splash/services/splash_service.dart';

final splashServiceProvider = Provider<SplashService>((ref) {
  return SplashService();
});

final splashControllerProvider = Provider<SplashController>((ref) {
  final SplashService splashService = ref.watch(splashServiceProvider);
  final OnboardingRepository onboardingRepository = OnboardingRepository();
  return SplashController(
    splashService: splashService,
    onboardingRepository: onboardingRepository,
  );
});

final class SplashController {
  SplashController({
    required this._splashService,
    required this._onboardingRepository,
  });

  final SplashService _splashService;
  final OnboardingRepository _onboardingRepository;

  Future<String> getInitialRoute() async {
    final bool isAuthenticated = await _splashService.isAuthenticated();
    
    if (isAuthenticated) {
      return AppRoutePaths.home;
    }
    
    final bool hasCompletedOnboarding = await _onboardingRepository.hasCompletedOnboarding();
    
    if (hasCompletedOnboarding) {
      return AppRoutePaths.login;
    } else {
      return AppRoutePaths.onboarding;
    }
  }
}
