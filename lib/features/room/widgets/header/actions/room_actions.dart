import 'package:flutter/material.dart';

import 'action_button.dart';

class RoomActions extends StatelessWidget {
  const RoomActions({
    super.key,
    required this.onShare,
    required this.onMinimize,
    required this.onExit,
  });

  final VoidCallback onShare;
  final VoidCallback onMinimize;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderActionButton(
          icon: Icons.ios_share_rounded,
          onTap: onShare,
          iconSize: 18,
        ),

        const SizedBox(width: 8),

        HeaderActionButton(
          icon: Icons.remove_rounded,
          onTap: onMinimize,
          iconSize: 20,
        ),

        const SizedBox(width: 8),

        HeaderActionButton(
          icon: Icons.close_rounded,
          onTap: onExit,
          iconSize: 18,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFF6B6B),
              Color(0xffD32F2F),
            ],
          ),
          borderColor: const Color(0xffFF8A80),
        ),
      ],
    );
  }
}