import 'package:flutter/material.dart';

class RoomAvatarBadge extends StatelessWidget {
  const RoomAvatarBadge({
    super.key,
    this.isOfficial = true,
    this.isVerified = true,
    this.size = 22,
  });

  final bool isOfficial;
  final bool isVerified;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (!isOfficial && !isVerified) {
      return const SizedBox.shrink();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff4FC3F7),
            Color(0xff1976D2),
          ],
        ),
        border: Border.all(
          color: Colors.white,
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff42A5F5).withValues(alpha: .40),
            blurRadius: 12,
            spreadRadius: 2,
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
          Positioned(
            top: 2,
            child: Container(
              width: size * .45,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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

          const Icon(
            Icons.verified_rounded,
            color: Colors.white,
            size: 14,
          ),
        ],
      ),
    );
  }
}