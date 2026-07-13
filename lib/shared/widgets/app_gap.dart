import 'package:flutter/widgets.dart';

import 'package:joojo_chat/core/theme/app_spacing.dart';

final class AppGap extends StatelessWidget {
  const AppGap.vertical(
    this.size, {
    super.key,
  }) : axis = Axis.vertical;

  const AppGap.horizontal(
    this.size, {
    super.key,
  }) : axis = Axis.horizontal;

  const AppGap.xs({super.key})
      : size = AppSpacing.xs,
        axis = Axis.vertical;

  const AppGap.sm({super.key})
      : size = AppSpacing.sm,
        axis = Axis.vertical;

  const AppGap.md({super.key})
      : size = AppSpacing.md,
        axis = Axis.vertical;

  const AppGap.lg({super.key})
      : size = AppSpacing.lg,
        axis = Axis.vertical;

  const AppGap.xl({super.key})
      : size = AppSpacing.xl,
        axis = Axis.vertical;

  final double size;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.horizontal ? size : AppSpacing.none,
      height: axis == Axis.vertical ? size : AppSpacing.none,
    );
  }
}
