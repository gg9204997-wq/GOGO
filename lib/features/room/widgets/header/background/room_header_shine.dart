import 'package:flutter/material.dart';

class RoomHeaderShine extends StatelessWidget {
  const RoomHeaderShine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // لمعان أعلى الهيدر
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: .18),
                    Colors.white.withValues(alpha: .10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // لمعان مائل رئيسي
          Positioned(
            left: -70,
            top: -20,
            child: Transform.rotate(
              angle: -.30,
              child: Container(
                width: 150,
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: .08),
                      Colors.white.withValues(alpha: .24),
                      Colors.white.withValues(alpha: .08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // لمعان ثانوي
          Positioned(
            right: 30,
            top: -40,
            child: Transform.rotate(
              angle: .28,
              child: Container(
                width: 90,
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: .04),
                      Colors.white.withValues(alpha: .12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // انعكاس أسفل الصورة
          Positioned(
            left: 18,
            bottom: 8,
            child: Container(
              width: 95,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: .22),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // انعكاس فوق المعلومات
          Positioned(
            left: 140,
            top: 20,
            child: Container(
              width: 180,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: .12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // لمعان سفلي
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white.withValues(alpha: .05),
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