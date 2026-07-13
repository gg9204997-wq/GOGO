import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';

abstract final class AppProgressTheme {
  const AppProgressTheme._();

  static ProgressIndicatorThemeData get light => const ProgressIndicatorThemeData(
    color: AppColors.primary,
    circularTrackColor: AppColors.surfaceVariantLight,
    linearTrackColor: AppColors.surfaceVariantLight,
    linearMinHeight: AppSizes.progressIndicatorStroke,
  );

  static ProgressIndicatorThemeData get dark => const ProgressIndicatorThemeData(
    color: AppColors.primaryLight,
    circularTrackColor: AppColors.surfaceVariant,
    linearTrackColor: AppColors.surfaceVariant,
    linearMinHeight: AppSizes.progressIndicatorStroke,
  );
}
