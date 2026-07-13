import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';

abstract final class AppIconTheme {
  const AppIconTheme._();

  static IconThemeData get light => const IconThemeData(
    color: AppColors.textSecondaryLight,
    size: AppSizes.iconLg,
  );

  static IconThemeData get dark => const IconThemeData(
    color: AppColors.textSecondary,
    size: AppSizes.iconLg,
  );
}
