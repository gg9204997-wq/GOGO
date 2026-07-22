import 'package:flutter/material.dart';

class RoomRoomId extends StatelessWidget {
  const RoomRoomId({
    super.key,
    required this.roomId,
    required this.level,
    this.country,
    this.language,
  });

  final String roomId;
  final int level;
  final String? country;
  final String? language;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      runSpacing: 4,
      children: [
        _Chip(
          icon: Icons.tag_rounded,
          text: "#$roomId",
          color: const Color(0xff42A5F5),
        ),

        _Chip(
          icon: Icons.workspace_premium_rounded,
          text: "Lv.$level",
          color: const Color(0xffFFD54F),
        ),

        if ((country ?? '').isNotEmpty)
          _Chip(
            icon: Icons.public_rounded,
            text: country!,
            color: const Color(0xff66BB6A),
          ),

        if ((language ?? '').isNotEmpty)
          _Chip(
            icon: Icons.language_rounded,
            text: language!,
            color: const Color(0xffAB47BC),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 11,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}