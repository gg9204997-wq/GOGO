import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';

abstract final class AppSliderTheme {
  const AppSliderTheme._();

  static SliderThemeData get light => const SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.surfaceVariantLight,
    thumbColor: AppColors.primary,
    overlayColor: AppColors.primaryContainer,
    trackHeight: AppSizes.progressIndicatorStroke,
  );

  static SliderThemeData get dark => const SliderThemeData(
    activeTrackColor: AppColors.primaryLight,
    inactiveTrackColor: AppColors.surfaceVariant,
    thumbColor: AppColors.primaryLight,
    overlayColor: AppColors.primaryDark,
    trackHeight: AppSizes.progressIndicatorStroke,
  );
}
