import 'package:flutter/material.dart';

class RoomHeaderGradient extends StatelessWidget {
  const RoomHeaderGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // الطبقة الأساسية
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xff9D6DFF).withValues(alpha: .18),
                  Colors.transparent,
                  const Color(0xffFFD54F).withValues(alpha: .08),
                ],
              ),
            ),
          ),

          // لمعان علوي
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: .16),
                    Colors.white.withValues(alpha: .08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // انعكاس يسار
          Positioned(
            left: -40,
            top: -25,
            child: Transform.rotate(
              angle: -.28,
              child: Container(
                width: 210,
                height: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: .10),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // انعكاس يمين
          Positioned(
            right: -55,
            bottom: -20,
            child: Transform.rotate(
              angle: .35,
              child: Container(
                width: 220,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xffFFD54F)
                          .withValues(alpha: .14),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // هالة بنفسجية
          Positioned(
            left: 80,
            top: 10,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff8D5CFF)
                        .withValues(alpha: .20),
                    blurRadius: 70,
                    spreadRadius: 12,
                  ),
                ],
              ),
            ),
          ),

          // هالة ذهبية
          Positioned(
            right: 60,
            top: 0,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffFFD54F)
                        .withValues(alpha: .20),
                    blurRadius: 55,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),

          // تدرج سفلي
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: .18),
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