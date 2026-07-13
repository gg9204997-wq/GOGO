import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

abstract final class AppTextSelectionTheme {
  const AppTextSelectionTheme._();

  static TextSelectionThemeData get light => const TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionColor: AppColors.primaryContainer,
    selectionHandleColor: AppColors.primary,
  );

  static TextSelectionThemeData get dark => const TextSelectionThemeData(
    cursorColor: AppColors.primaryLight,
    selectionColor: AppColors.primaryDark,
    selectionHandleColor: AppColors.primaryLight,
  );
}
