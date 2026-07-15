import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:joojo_chat/app/app_config.dart';
import 'package:joojo_chat/core/constants/app_colors.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
      AppConfig.splashDuration,
      () {
        if (!mounted) return;
        context.go('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.forum_rounded,
              size: 90,
              color: AppColors.primary,
            ),

            const SizedBox(height: 24),

            Text(
              AppConfig.appName,
              style: AppTextStyles.displayLarge,
            ),

            const SizedBox(height: 12),

            const Text(
              'Voice • Chat • Community',
              style: AppTextStyles.bodySmall,
            ),

            const SizedBox(height: 50),

            const SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}