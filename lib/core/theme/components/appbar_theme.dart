import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

abstract final class AppAppBarTheme {
  const AppAppBarTheme._();

  static AppBarTheme get light => AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.surfaceLight,
    foregroundColor: AppColors.textPrimaryLight,
    shadowColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    iconTheme: const IconThemeData(
      color: AppColors.textPrimaryLight,
      size: AppSizes.iconMd,
    ),
    actionsIconTheme: const IconThemeData(
      color: AppColors.textPrimaryLight,
      size: AppSizes.iconMd,
    ),
    titleTextStyle: AppTextStyles.titleLarge,
    toolbarHeight: AppSizes.appBarHeight,
  );

  static AppBarTheme get dark => AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimary,
    shadowColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    iconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: AppSizes.iconMd,
    ),
    actionsIconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: AppSizes.iconMd,
    ),
    titleTextStyle: AppTextStyles.titleLarge,
    toolbarHeight: AppSizes.appBarHeight,
  );

  static TextStyle get lightTitle => AppTextStyles.titleLarge.copyWith(
        color: AppColors.textPrimaryLight,
      );

  static TextStyle get darkTitle => AppTextStyles.titleLarge.copyWith(
        color: AppColors.textPrimary,
      );
}
