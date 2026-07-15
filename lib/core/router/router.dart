import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:joojo_chat/features/auth/screens/login_screen.dart';
import 'package:joojo_chat/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

    ],

    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text(
            state.error.toString(),
          ),
        ),
      );
    },
  );
}