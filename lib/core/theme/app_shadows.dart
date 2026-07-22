import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

abstract final class AppShadows {
  AppShadows._();

  static final purpleGlow = [
    const BoxShadow(
      color: AppColors.glow,
      blurRadius: 30,
      spreadRadius: 2,
      offset: Offset(0, 10),
    ),
  ];

  static final soft = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .35),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  static final card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.18),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}