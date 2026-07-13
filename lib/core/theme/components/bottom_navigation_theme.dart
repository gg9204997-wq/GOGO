import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

abstract final class AppBottomNavigationTheme {
  const AppBottomNavigationTheme._();

  static BottomNavigationBarThemeData get light =>
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textHintLight,
    type: BottomNavigationBarType.fixed,
    elevation: AppSizes.zero,
    selectedLabelStyle: AppTextStyles.labelSmall,
    unselectedLabelStyle: AppTextStyles.labelSmall,
  );

  static BottomNavigationBarThemeData get dark =>
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.background,
    selectedItemColor: AppColors.primaryLight,
    unselectedItemColor: AppColors.textHint,
    type: BottomNavigationBarType.fixed,
    elevation: AppSizes.zero,
    selectedLabelStyle: AppTextStyles.labelSmall,
    unselectedLabelStyle: AppTextStyles.labelSmall,
  );

  static NavigationBarThemeData get navigationLight =>
      NavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
    indicatorColor: AppColors.primaryContainer,
    elevation: AppSizes.zero,
    height: AppSizes.bottomNavigationHeight,
    labelTextStyle: WidgetStatePropertyAll<TextStyle>(
      AppTextStyles.labelSmall,
    ),
    iconTheme: const WidgetStatePropertyAll<IconThemeData>(
      IconThemeData(
        color: AppColors.textSecondaryLight,
        size: AppSizes.iconLg,
      ),
    ),
  );

  static NavigationBarThemeData get navigationDark =>
      NavigationBarThemeData(
    backgroundColor: AppColors.background,
    indicatorColor: AppColors.surfaceVariant,
    elevation: AppSizes.zero,
    height: AppSizes.bottomNavigationHeight,
    labelTextStyle: WidgetStatePropertyAll<TextStyle>(
      AppTextStyles.labelSmall,
    ),
    iconTheme: const WidgetStatePropertyAll<IconThemeData>(
      IconThemeData(
        color: AppColors.textSecondary,
        size: AppSizes.iconLg,
      ),
    ),
  );
}
