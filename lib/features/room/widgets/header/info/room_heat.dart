import 'package:flutter/material.dart';

class RoomHeat extends StatelessWidget {
  const RoomHeat({
    super.key,
    required this.heat,
    required this.online,
    required this.gifts,
  });

  final int heat;
  final int online;
  final int gifts;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Badge(
          icon: Icons.local_fire_department_rounded,
          color: const Color(0xffFF7043),
          text: _format(heat),
        ),

        const SizedBox(width: 6),

        _Badge(
          icon: Icons.people_alt_rounded,
          color: const Color(0xff42A5F5),
          text: _format(online),
        ),

        const SizedBox(width: 6),

        _Badge(
          icon: Icons.card_giftcard_rounded,
          color: const Color(0xffFFD54F),
          text: _format(gifts),
        ),
      ],
    );
  }

  String _format(int value) {
    if (value >= 1000000) {
      return "${(value / 1000000).toStringAsFixed(1)}M";
    }

    if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(1)}K";
    }

    return value.toString();
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color.withOpacity(.15),
        border: Border.all(
          color: color.withOpacity(.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
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