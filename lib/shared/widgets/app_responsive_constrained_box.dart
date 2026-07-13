import 'package:flutter/widgets.dart';

import 'package:joojo_chat/core/theme/app_sizes.dart';

final class AppResponsiveConstrainedBox extends StatelessWidget {
  const AppResponsiveConstrainedBox({
    required this.child,
    super.key,
    this.maxWidth = AppSizes.maxContentWidth,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }
}
