import 'package:flutter/material.dart';

class RoomAvatarFrame extends StatelessWidget {
  const RoomAvatarFrame({
    super.key,
    this.size = 86,
    required this.child,
  });

  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow الخارجي
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffFFD54F)
                      .withValues(alpha: .35),
                  blurRadius: 26,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: const Color(0xff8E5CFF)
                      .withValues(alpha: .22),
                  blurRadius: 42,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),

          // الحلقة الخارجية
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xffFFF8C5),
                  Color(0xffFFE082),
                  Color(0xffFFD54F),
                  Color(0xffFFCA28),
                  Color(0xffFFB300),
                  Color(0xffFFD54F),
                  Color(0xffFFF8C5),
                ],
              ),
            ),
          ),

          // حلقة الظل
          Container(
            width: size - 4,
            height: size - 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff8A5A00),
                width: 1.3,
              ),
            ),
          ),

          // حلقة اللمعة
          Container(
            width: size - 8,
            height: size - 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: .35),
                width: .8,
              ),
            ),
          ),

          // الصورة
          Container(
            width: size - 12,
            height: size - 12,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: child,
          ),

          // لمعان علوي
          Positioned(
            top: 5,
            child: Container(
              width: size * .55,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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

          // لمعان يسار
          Positioned(
            left: 8,
            top: 18,
            child: Container(
              width: 5,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withValues(alpha: .40),
              ),
            ),
          ),

          // جوهرة أعلى
          Positioned(
            top: 2,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xffFFE082),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffFFD54F)
                        .withValues(alpha: .60),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),

          // جوهرة يمين
          Positioned(
            right: 4,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xffFFD54F),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffFFD54F)
                        .withValues(alpha: .55),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),

          // جوهرة أسفل
          Positioned(
            bottom: 3,
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: const Color(0xffFFF3B0),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffFFD54F)
                        .withValues(alpha: .50),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}