import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

abstract final class AppTextStyles {
  AppTextStyles._();

  static const title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.white,
  );

  static const caption = TextStyle(
    fontSize: 13,
    color: AppColors.grey,
  );

  static const button = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}