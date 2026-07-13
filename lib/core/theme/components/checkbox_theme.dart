import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';

abstract final class AppCheckboxTheme {
  const AppCheckboxTheme._();

  static CheckboxThemeData get light => CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.transparent;
          },
        ),
        checkColor: const WidgetStatePropertyAll<Color>(AppColors.onPrimary),
        side: const BorderSide(
          color: AppColors.borderLight,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.radiusSm,
        ),
      );

  static CheckboxThemeData get dark => CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.transparent;
          },
        ),
        checkColor: const WidgetStatePropertyAll<Color>(AppColors.onPrimary),
        side: const BorderSide(
          color: AppColors.border,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.radiusSm,
        ),
      );
}
