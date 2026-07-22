import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderActionButton extends StatelessWidget {
  const HeaderActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 38,
    this.iconSize = 18,
    this.gradient,
    this.borderColor,
    this.iconColor = Colors.white,
    this.showGlow = true,
  });

  final IconData icon;
  final VoidCallback onTap;

  final double size;
  final double iconSize;

  final Gradient? gradient;
  final Color? borderColor;
  final Color iconColor;
  final bool showGlow;

  @override
  Widget build(BuildContext context) {
    final border = borderColor ?? Colors.white.withValues(alpha: .18);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: showGlow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .22),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: const Color(0xff9C6BFF)
                        .withValues(alpha: .16),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 12,
              sigmaY: 12,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradient ??
                    LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: .16),
                        Colors.white.withValues(alpha: .06),
                      ],
                    ),
                border: Border.all(
                  color: border,
                  width: 1,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 4,
                    child: Container(
                      width: size * .45,
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withValues(alpha: .75),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}