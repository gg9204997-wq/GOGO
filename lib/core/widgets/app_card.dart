import 'package:flutter/material.dart';

import 'package:joojo_chat/core/constants/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  final EdgeInsets padding;
  final EdgeInsets margin;

  final VoidCallback? onTap;

  const AppCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}