import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

abstract final class AppButtonTheme {
  const AppButtonTheme._();

  static ElevatedButtonThemeData get light => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          padding: AppSpacing.button,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.textDisabled,
          disabledForegroundColor: AppColors.textHint,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.radiusXL,
          ),
          textStyle: AppTextStyles.buttonLarge,
        ),
      );

  static ElevatedButtonThemeData get dark => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          padding: AppSpacing.button,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.textDisabled,
          disabledForegroundColor: AppColors.textHint,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.radiusXL,
          ),
          textStyle: AppTextStyles.buttonLarge,
        ),
      );

  static FilledButtonThemeData get filled => FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.radiusXL,
          ),
          textStyle: AppTextStyles.buttonLarge,
        ),
      );

  static OutlinedButtonThemeData get outlined => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          side: const BorderSide(
            color: AppColors.primary,
            width: AppSizes.borderRegular,
          ),
          foregroundColor: AppColors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.radiusXL,
          ),
          textStyle: AppTextStyles.buttonLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
      );

  static TextButtonThemeData get text => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.labelLarge,
        ),
      );

  static IconButtonThemeData get icon => IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.primary,
          iconSize: AppSizes.iconLg,
          padding: AppSpacing.iconButton,
        ),
      );
}
