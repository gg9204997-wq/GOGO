import 'package:flutter/material.dart';

class OnlineIndicator extends StatelessWidget {
  const OnlineIndicator({
    super.key,
    this.size = 10,
    this.isOnline = true,
    this.color = const Color(0xff00E676),
  });

  final double size;
  final bool isOnline;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (!isOnline) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Glow
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: .55),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),

          // Main Circle
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: .95),
                  color,
                  const Color(0xff00C853),
                ],
              ),
              border: Border.all(
                color: Colors.white,
                width: 1.2,
              ),
            ),
          ),

          // Highlight
          Positioned(
            top: 1,
            child: Container(
              width: size * .45,
              height: size * .18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: .95),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Inner Shine
          Container(
            width: size * .35,
            height: size * .35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: .35),
            ),
          ),
        ],
      ),
    );
  }
}