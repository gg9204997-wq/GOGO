import 'package:flutter/material.dart';

import 'member_avatar.dart';

class RoomMembers extends StatelessWidget {
  const RoomMembers({
    super.key,
    required this.members,
    required this.totalMembers,
    this.maxVisible = 5,
  });

  final List<MemberAvatarData> members;
  final int totalMembers;
  final int maxVisible;

  @override
  Widget build(BuildContext context) {
    final visible = members.take(maxVisible).toList();

    return Row(
      children: [
        SizedBox(
          width: (visible.length * 24) + 18,
          height: 38,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < visible.length; i++)
                Positioned(
                  left: i * 24,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .22),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: MemberAvatar(
                      member: visible[i],
                      size: 34,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: .12),
                  Colors.white.withValues(alpha: .05),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: .08),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.people_alt_rounded,
                  color: Colors.white,
                  size: 15,
                ),
                const SizedBox(width: 6),
                Text(
                  _format(totalMembers),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _format(int value) {
    if (value >= 1000000) {
      return "${(value / 1000000).toStringAsFixed(1)}M";
    }

    if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(1)}K";
    }

    return value.toString();
  }
}