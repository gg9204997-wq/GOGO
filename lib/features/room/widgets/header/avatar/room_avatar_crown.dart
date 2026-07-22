import 'package:flutter/material.dart';

class RoomAvatarCrown extends StatelessWidget {
  const RoomAvatarCrown({
    super.key,
    this.size = 34,
    this.visible = true,
  });

  final double size;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffFFD54F)
                      .withValues(alpha: .45),
                  blurRadius: 18,
                  spreadRadius: 3,
                ),
              ],
            ),
          ),

          // Background
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffFFF8C5),
                  Color(0xffFFD54F),
                  Color(0xffFFB300),
                ],
              ),
              border: Border.all(
                color: Colors.white,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .22),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),

          // Shine
          Positioned(
            top: 3,
            child: Container(
              width: size * .55,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: .9),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Crown Icon
          const Icon(
            Icons.workspace_premium_rounded,
            color: Color(0xff8A5A00),
            size: 19,
          ),

          // Gem
          Positioned(
            bottom: 6,
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE91E63),
              ),
            ),
          ),
        ],
      ),
    );
  }
}