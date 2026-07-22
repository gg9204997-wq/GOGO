import 'package:flutter/material.dart';

import 'room_avatar_badge.dart';
import 'room_avatar_crown.dart';
import 'room_avatar_effect.dart';
import 'room_avatar_frame.dart';
import 'room_avatar_level.dart';

class RoomAvatar extends StatelessWidget {
  const RoomAvatar({
    super.key,
    this.imageUrl,
    required this.level,
    required this.isOfficial,
    required this.isVerified,
    this.size = 72,
  });

  final String? imageUrl;
  final int level;
  final bool isOfficial;
  final bool isVerified;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          const RoomAvatarEffect(),

          RoomAvatarFrame(
            child: ClipOval(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      width: size - 8,
                      height: size - 8,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _placeholder(),
                    )
                  : _placeholder(),
            ),
          ),

          Positioned(
            bottom: -2,
            child: RoomAvatarLevel(
              level: level,
            ),
          ),

          if (isOfficial)
            const Positioned(
              top: -4,
              child: RoomAvatarCrown(),
            ),

          if (isVerified)
            const Positioned(
              right: -2,
              bottom: 6,
              child: RoomAvatarBadge(),
            ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xff2E3446),
      alignment: Alignment.center,
      child: const Icon(
        Icons.home_rounded,
        color: Colors.white70,
        size: 32,
      ),
    );
  }
}