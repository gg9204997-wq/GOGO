import 'package:flutter/material.dart';

import 'seat_frame.dart';
import 'speaking_glow.dart';

class SeatEffect extends StatelessWidget {
  const SeatEffect({
    super.key,
    required this.child,
    this.isSpeaking = false,
    this.isVip = false,
    this.isAdmin = false,
    this.isLocked = false,
    this.showFrame = true,
    this.showGlow = true,
    this.size = 82,
  });

  final Widget child;

  final bool isSpeaking;

  final bool isVip;

  final bool isAdmin;

  final bool isLocked;

  final bool showFrame;

  final bool showGlow;

  final double size;

  @override
  Widget build(BuildContext context) {
    Widget avatar = SizedBox(
      width: size,
      height: size,
      child: child,
    );

    if (showFrame) {
      if (isVip) {
        avatar = VipSeatFrame(
          size: size,
          child: avatar,
        );
      } else if (isAdmin) {
        avatar = AdminSeatFrame(
          size: size,
          child: avatar,
        );
      } else {
        avatar = SeatFrame(
          size: size,
          child: avatar,
        );
      }
    }

    if (showGlow) {
      avatar = SpeakingGlow(
        size: size + 12,
        isSpeaking: isSpeaking,
        child: avatar,
      );
    }

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [

        avatar,

        if (isLocked)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black45,
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),

        if (isSpeaking)
          Positioned(
            bottom: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: const Text(
                "Speaking",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        if (isVip)
          const Positioned(
            top: -4,
            right: -2,
            child: Icon(
              Icons.workspace_premium,
              color: Color(0xffFBC02D),
              size: 22,
            ),
          ),

        if (isAdmin)
          const Positioned(
            top: -4,
            left: -2,
            child: Icon(
              Icons.shield,
              color: Colors.red,
              size: 20,
            ),
          ),
      ],
    );
  }
}