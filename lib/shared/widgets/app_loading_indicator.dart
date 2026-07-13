import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_sizes.dart';

final class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = AppSizes.iconXl,
    this.strokeWidth = AppSizes.progressIndicatorStroke,
  });

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
      ),
    );
  }
}
