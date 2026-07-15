import 'package:flutter/material.dart';

import 'package:joojo_chat/core/constants/app_colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    this.size = 36,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 3,
      ),
    );
  }
}