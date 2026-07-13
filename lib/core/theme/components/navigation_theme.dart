import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

abstract final class AppNavigationTheme {
  const AppNavigationTheme._();

  static NavigationRailThemeData get railLight => NavigationRailThemeData(
    backgroundColor: AppColors.surfaceLight,
    selectedIconTheme: const IconThemeData(
      color: AppColors.primary,
      size: AppSizes.iconLg,
    ),
    unselectedIconTheme: const IconThemeData(
      color: AppColors.textHintLight,
      size: AppSizes.iconLg,
    ),
    selectedLabelTextStyle: AppTextStyles.labelMedium,
    unselectedLabelTextStyle: AppTextStyles.labelMedium,
  );

  static NavigationRailThemeData get railDark => NavigationRailThemeData(
    backgroundColor: AppColors.background,
    selectedIconTheme: const IconThemeData(
      color: AppColors.primaryLight,
      size: AppSizes.iconLg,
    ),
    unselectedIconTheme: const IconThemeData(
      color: AppColors.textHint,
      size: AppSizes.iconLg,
    ),
    selectedLabelTextStyle: AppTextStyles.labelMedium,
    unselectedLabelTextStyle: AppTextStyles.labelMedium,
  );
}
