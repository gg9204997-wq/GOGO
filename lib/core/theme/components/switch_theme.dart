import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

abstract final class AppSwitchTheme {
  const AppSwitchTheme._();

  static SwitchThemeData get light => SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.white;
            }
            return AppColors.textHintLight;
          },
        ),
        trackColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.surfaceVariantLight;
          },
        ),
      );

  static SwitchThemeData get dark => SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.white;
            }
            return AppColors.textHint;
          },
        ),
        trackColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.surfaceVariant;
          },
        ),
      );
}
