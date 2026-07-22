import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

abstract final class AppGradients {
  AppGradients._();

  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primary,
      AppColors.secondary,
    ],
  );

  static const vip = LinearGradient(
    colors: [
      Color(0xffFFD54F),
      Color(0xffFFB300),
    ],
  );

  static const dark = LinearGradient(
    colors: [
      Color(0xff18122D),
      Color(0xff0B0918),
    ],
  );
}