import 'package:flutter/material.dart';

class RoomHeaderLight extends StatelessWidget {
  const RoomHeaderLight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // شعاع ذهبي يسار
          Positioned(
            left: -80,
            top: -35,
            child: Transform.rotate(
              angle: -.42,
              child: Container(
                width: 240,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xffFFD54F).withValues(alpha: .22),
                      const Color(0xffFFE082).withValues(alpha: .12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // شعاع أبيض علوي
          Positioned(
            top: -25,
            left: 120,
            child: Transform.rotate(
              angle: -.12,
              child: Container(
                width: 220,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: .16),
                      Colors.white.withValues(alpha: .08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // شعاع ذهبي يمين
          Positioned(
            right: -90,
            top: -18,
            child: Transform.rotate(
              angle: .36,
              child: Container(
                width: 250,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      const Color(0xffFFD54F).withValues(alpha: .16),
                      const Color(0xffFFE082).withValues(alpha: .26),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // إضاءة منتصف الهيدر
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 320,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: .07),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // إضاءة أسفل الصورة
          Positioned(
            left: 18,
            bottom: -10,
            child: Container(
              width: 120,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xffFFD54F).withValues(alpha: .15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // إضاءة يمين
          Positioned(
            right: 18,
            bottom: -5,
            child: Container(
              width: 150,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xffFFFFFF).withValues(alpha: .05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}