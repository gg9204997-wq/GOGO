import 'package:flutter/material.dart';

import 'package:joojo_chat/features/room/widgets/mic/mic_avatar.dart';
import 'package:joojo_chat/features/room/widgets/mic/mic_lock.dart';
import 'package:joojo_chat/features/room/widgets/mic/mic_wave.dart';

class MicSeat extends StatelessWidget {
  const MicSeat({
    super.key,
    required this.seatNumber,
    this.avatarUrl = '',
    this.username = '',
    this.isLocked = false,
    this.isMuted = false,
    this.isSpeaking = false,
    this.isOwner = false,
    this.isVip = false,
    this.onTap,
    this.onLongPress,
  });

  final int seatNumber;

  final String avatarUrl;
  final String username;

  final bool isLocked;
  final bool isMuted;
  final bool isSpeaking;
  final bool isOwner;
  final bool isVip;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  bool get hasUser => avatarUrl.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: 90,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (isSpeaking)
                  MicWave(
                    size: 82,
                    color: Colors.greenAccent,
                  ),

                if (hasUser)
                  MicAvatar(
                    imageUrl: avatarUrl,
                    size: 60,
                    isSpeaking: isSpeaking,
                    isMuted: isMuted,
                  )
                else
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white24,
                      ),
                    ),
                    child: Icon(
                      isLocked
                          ? Icons.lock
                          : Icons.mic,
                      color: Colors.white54,
                    ),
                  ),

                if (isLocked)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: MicLock(
                      locked: true,
                      size: 16,
                    ),
                  ),

                if (isOwner)
                  const Positioned(
                    left: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),

                if (isVip)
                  const Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.purple,
                      child: Icon(
                        Icons.workspace_premium,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              hasUser
                  ? username
                  : 'Seat $seatNumber',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}