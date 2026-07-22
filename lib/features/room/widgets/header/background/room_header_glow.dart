import 'package:flutter/material.dart';

class RoomHeaderGlow extends StatelessWidget {
  const RoomHeaderGlow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Glow خلف صورة الغرفة
          Positioned(
            left: -35,
            top: -10,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff8B5CF6)
                        .withValues(alpha: .35),
                    blurRadius: 80,
                    spreadRadius: 18,
                  ),
                  BoxShadow(
                    color: const Color(0xffFFD54F)
                        .withValues(alpha: .18),
                    blurRadius: 55,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),

          // Glow خلف المعلومات
          Positioned(
            left: 150,
            top: 5,
            child: Container(
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffA970FF)
                        .withValues(alpha: .14),
                    blurRadius: 65,
                    spreadRadius: 12,
                  ),
                ],
              ),
            ),
          ),

          // Glow ذهبي يمين
          Positioned(
            right: -20,
            top: -10,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffFFD54F)
                        .withValues(alpha: .20),
                    blurRadius: 50,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),

          // إضاءة وسطية
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 260,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: .05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Halo أعلى
          Positioned(
            top: -30,
            left: 120,
            child: Container(
              width: 180,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: .08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Halo أسفل
          Positioned(
            bottom: -20,
            right: 50,
            child: Container(
              width: 180,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xffFFD54F)
                        .withValues(alpha: .08),
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