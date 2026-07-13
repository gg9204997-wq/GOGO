import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';

abstract final class AppScrollbarTheme {
  const AppScrollbarTheme._();

  static ScrollbarThemeData get light => const ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll<Color>(
          AppColors.textHintLight,
        ),
        radius: AppRadius.pill,
        thickness: WidgetStatePropertyAll<double>(
          AppSizes.borderFocus,
        ),
      );

  static ScrollbarThemeData get dark => const ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll<Color>(
          AppColors.textHint,
        ),
        radius: AppRadius.pill,
        thickness: WidgetStatePropertyAll<double>(
          AppSizes.borderFocus,
        ),
      );
}
