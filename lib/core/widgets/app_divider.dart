import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppDivider extends StatelessWidget {
  final double height;

  const AppDivider({
    super.key,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColors.divider,
    );
  }
}