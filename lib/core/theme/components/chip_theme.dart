import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

abstract final class AppChipTheme {
  const AppChipTheme._();

  static ChipThemeData get light => ChipThemeData(
        backgroundColor: AppColors.surfaceVariantLight,
        selectedColor: AppColors.primaryContainer,
        disabledColor: AppColors.surfaceVariantLight,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: AppColors.textSecondaryLight,
        ),
        secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
          color: AppColors.primary,
        ),
        padding: AppSpacing.allSm,
        side: const BorderSide(
          color: AppColors.borderLight,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.radiusPill,
        ),
      );

  static ChipThemeData get dark => ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primaryDark,
        disabledColor: AppColors.surfaceVariant,
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
          color: AppColors.primaryLight,
        ),
        padding: AppSpacing.allSm,
        side: const BorderSide(
          color: AppColors.border,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.radiusPill,
        ),
      );
}
