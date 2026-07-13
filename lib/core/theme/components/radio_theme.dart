import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

abstract final class AppRadioTheme {
  const AppRadioTheme._();

  static RadioThemeData get light => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.textHintLight;
          },
        ),
      );

  static RadioThemeData get dark => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primaryLight;
            }
            return AppColors.textHint;
          },
        ),
      );
}
