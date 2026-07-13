import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

abstract final class AppDialogTheme {
  const AppDialogTheme._();

  static DialogThemeData get light => DialogThemeData(
        backgroundColor: AppColors.surfaceLight,
        surfaceTintColor: AppColors.transparent,
        elevation: AppSizes.zero,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondaryLight,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.radiusXxl,
        ),
      );

  static DialogThemeData get dark => DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: AppColors.transparent,
        elevation: AppSizes.zero,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.radiusXxl,
        ),
      );
}
