import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/core/router/app_route_paths.dart';
import 'package:joojo_chat/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:joojo_chat/features/auth/presentation/pages/login_page.dart';
import 'package:joojo_chat/features/auth/presentation/pages/register_page.dart';
import 'package:joojo_chat/features/home/presentation/pages/home_page.dart';
import 'package:joojo_chat/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:joojo_chat/features/splash/presentation/pages/splash_page.dart';
abstract final class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutePaths.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutePaths.splash,
        name: AppRouteNames.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.onboarding,
        name: AppRouteNames.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.login,
        name: AppRouteNames.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.register,
        name: AppRouteNames.register,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.forgotPassword,
        name: AppRouteNames.forgotPassword,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordPage();
        },
      ),
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
    ],
  );
}

abstract final class AppRouteNames {
  const AppRouteNames._();

  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String register = 'register';
  static const String forgotPassword = 'forgot-password';
  static const String home = 'home';
}
