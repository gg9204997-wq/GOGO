import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';

abstract final class AppBottomSheetTheme {
  const AppBottomSheetTheme._();

  static BottomSheetThemeData get light => const BottomSheetThemeData(
    backgroundColor: AppColors.surfaceLight,
    modalBackgroundColor: AppColors.surfaceLight,
    surfaceTintColor: AppColors.transparent,
    elevation: AppSizes.zero,
    modalElevation: AppSizes.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: AppRadius.xxl,
      ),
    ),
  );

  static BottomSheetThemeData get dark => const BottomSheetThemeData(
    backgroundColor: AppColors.surface,
    modalBackgroundColor: AppColors.surface,
    surfaceTintColor: AppColors.transparent,
    elevation: AppSizes.zero,
    modalElevation: AppSizes.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: AppRadius.xxl,
      ),
    ),
  );
}
