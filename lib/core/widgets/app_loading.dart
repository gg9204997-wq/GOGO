import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

class AppLoading extends StatelessWidget {
  final double size;

  const AppLoading({
    super.key,
    this.size = 35,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 3,
        ),
      ),
    );
  }
}