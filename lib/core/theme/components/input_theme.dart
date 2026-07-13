import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

abstract final class AppInputTheme {
  const AppInputTheme._();

  static InputDecorationTheme get light {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceVariantLight,
      isDense: true,
      contentPadding: AppSpacing.input,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textHintLight,
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondaryLight,
      ),
      floatingLabelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.primary,
      ),
      errorStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.error,
      ),
      prefixIconColor: AppColors.textSecondaryLight,
      suffixIconColor: AppColors.textSecondaryLight,
      border: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.borderLight,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.borderLight,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppSizes.borderFocus,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.error,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.error,
          width: AppSizes.borderFocus,
        ),
      ),
    );
  }

  static InputDecorationTheme get dark {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      isDense: true,
      contentPadding: AppSpacing.input,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textHint,
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondary,
      ),
      floatingLabelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.primary,
      ),
      errorStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.error,
      ),
      prefixIconColor: AppColors.textSecondary,
      suffixIconColor: AppColors.textSecondary,
      border: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.border,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppSizes.borderFocus,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.error,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.radiusXL,
        borderSide: BorderSide(
          color: AppColors.error,
          width: AppSizes.borderFocus,
        ),
      ),
    );
  }
}
