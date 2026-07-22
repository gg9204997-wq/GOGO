import 'package:flutter/material.dart';

class UserLevelBadge extends StatelessWidget {
  final int level;
  final double height;
  final bool showIcon;

  const UserLevelBadge({
    super.key,
    required this.level,
    this.height = 22,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _colors,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: _colors.first.withValues(alpha: .35),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 12,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            "Lv.$level",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Color> get _colors {
    if (level >= 120) {
      return const [
        Color(0xffFFD700),
        Color(0xffFF8C00),
      ];
    }

    if (level >= 90) {
      return const [
        Color(0xffE91E63),
        Color(0xff9C27B0),
      ];
    }

    if (level >= 70) {
      return const [
        Color(0xff7B61FF),
        Color(0xff5B42F3),
      ];
    }

    if (level >= 50) {
      return const [
        Color(0xff2196F3),
        Color(0xff1565C0),
      ];
    }

    if (level >= 30) {
      return const [
        Color(0xff00BCD4),
        Color(0xff0097A7),
      ];
    }

    if (level >= 15) {
      return const [
        Color(0xff4CAF50),
        Color(0xff2E7D32),
      ];
    }

    return const [
      Color(0xff757575),
      Color(0xff424242),
    ];
  }
}