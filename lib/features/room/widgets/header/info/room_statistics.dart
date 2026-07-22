import 'package:flutter/material.dart';

class RoomStatistics extends StatelessWidget {
  const RoomStatistics({
    super.key,
    required this.heat,
    required this.online,
    required this.visitors,
    required this.gifts,
  });

  final int heat;
  final int online;
  final int visitors;
  final int gifts;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _StatItem(
          icon: Icons.local_fire_department_rounded,
          color: const Color(0xffFF7043),
          value: _format(heat),
          label: "Heat",
        ),
        _StatItem(
          icon: Icons.people_rounded,
          color: const Color(0xff42A5F5),
          value: _format(online),
          label: "Online",
        ),
        _StatItem(
          icon: Icons.visibility_rounded,
          color: const Color(0xff66BB6A),
          value: _format(visitors),
          label: "Visitors",
        ),
        _StatItem(
          icon: Icons.card_giftcard_rounded,
          color: const Color(0xffFFD54F),
          value: _format(gifts),
          label: "Gifts",
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

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(.12),
            Colors.white.withOpacity(.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(.08),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(.65),
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}