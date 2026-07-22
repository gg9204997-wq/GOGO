import 'package:flutter/material.dart';

class RoomTitle extends StatelessWidget {
  const RoomTitle({
    super.key,
    required this.title,
    this.isOfficial = false,
    this.isVerified = false,
    this.isLocked = false,
    this.isLive = true,
  });

  final String title;
  final bool isOfficial;
  final bool isVerified;
  final bool isLocked;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        if (isOfficial) ...[
          const SizedBox(width: 6),
          const Icon(
            Icons.verified,
            color: Color(0xff42A5F5),
            size: 18,
          ),
        ],

        if (isVerified) ...[
          const SizedBox(width: 4),
          const Icon(
            Icons.workspace_premium,
            color: Color(0xffFFD54F),
            size: 18,
          ),
        ],

        if (isLocked) ...[
          const SizedBox(width: 4),
          const Icon(
            Icons.lock_rounded,
            color: Colors.orange,
            size: 16,
          ),
        ],

        if (isLive) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "LIVE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}