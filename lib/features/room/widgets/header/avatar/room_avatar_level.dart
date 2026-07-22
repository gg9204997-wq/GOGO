import 'package:flutter/material.dart';

class RoomAvatarLevel extends StatelessWidget {
  const RoomAvatarLevel({
    super.key,
    required this.level,
    this.width = 56,
    this.height = 20,
  });

  final int level;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFFE082),
            Color(0xffFFC107),
            Color(0xffFF9800),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: .22),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffFFC107).withValues(alpha: .45),
            blurRadius: 12,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: .25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // لمعان
          Positioned(
            top: 2,
            left: 8,
            right: 8,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: .85),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                color: Color(0xff8D5A00),
                size: 11,
              ),
              const SizedBox(width: 3),
              Text(
                'Lv.$level',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  letterSpacing: .2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}