import 'package:flutter/material.dart';

class RoomAvatarEffect extends StatelessWidget {
  const RoomAvatarEffect({
    super.key,
    this.size = 86,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: size + 50,
        height: size + 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Purple Aura
            Container(
              width: size + 42,
              height: size + 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff8D5CFF)
                        .withValues(alpha: .30),
                    blurRadius: 70,
                    spreadRadius: 12,
                  ),
                ],
              ),
            ),

            // Gold Aura
            Container(
              width: size + 22,
              height: size + 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffFFD54F)
                        .withValues(alpha: .28),
                    blurRadius: 35,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),

            // Soft White Glow
            Container(
              width: size + 10,
              height: size + 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: .08),
                ),
              ),
            ),

            // Top Shine
            Positioned(
              top: 6,
              child: Container(
                width: size * .70,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white.withValues(alpha: .70),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Left Spark
            Positioned(
              left: 8,
              top: 22,
              child: _dot(
                const Color(0xffFFD54F),
                8,
              ),
            ),

            // Right Spark
            Positioned(
              right: 10,
              bottom: 18,
              child: _dot(
                Colors.white,
                6,
              ),
            ),

            // Bottom Spark
            Positioned(
              bottom: 4,
              child: _dot(
                const Color(0xffFFE082),
                5,
              ),
            ),

            // Decorative Stars
            const Positioned(
              left: 18,
              bottom: 18,
              child: Icon(
                Icons.auto_awesome,
                size: 10,
                color: Color(0xffFFD54F),
              ),
            ),

            const Positioned(
              right: 18,
              top: 16,
              child: Icon(
                Icons.auto_awesome,
                size: 9,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .45),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}