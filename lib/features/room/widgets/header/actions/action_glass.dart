import 'dart:ui';

import 'package:flutter/material.dart';

class ActionGlass extends StatelessWidget {
  const ActionGlass({
    super.key,
    required this.child,
    this.size = 38,
    this.borderRadius = 19,
    this.padding = EdgeInsets.zero,
    this.gradient,
    this.borderColor,
    this.blur = 16,
    this.showShadow = true,
  });

  final Widget child;
  final double size;
  final double borderRadius;
  final EdgeInsets padding;
  final Gradient? gradient;
  final Color? borderColor;
  final double blur;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          width: size,
          height: size,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: gradient ??
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: .18),
                    Colors.white.withValues(alpha: .08),
                    Colors.white.withValues(alpha: .04),
                  ],
                ),
            border: Border.all(
              color: borderColor ??
                  Colors.white.withValues(alpha: .14),
            ),
            boxShadow: showShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .22),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: const Color(0xff8D5CFF)
                          .withValues(alpha: .10),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 3,
                left: 6,
                right: 6,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white.withValues(alpha: .80),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              Center(child: child),
            ],
          ),
        ),
      ),
    );
  }
}