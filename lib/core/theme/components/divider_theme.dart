import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';

abstract final class AppDividerTheme {
  const AppDividerTheme._();

  static DividerThemeData get light => const DividerThemeData(
    color: AppColors.dividerLight,
    thickness: AppSizes.dividerThickness,
    space: AppSizes.dividerThickness,
  );

  static DividerThemeData get dark => const DividerThemeData(
    color: AppColors.divider,
    thickness: AppSizes.dividerThickness,
    space: AppSizes.dividerThickness,
  );
}
