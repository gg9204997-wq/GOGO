import 'package:flutter/material.dart';

class RoomProgress extends StatelessWidget {
  const RoomProgress({
    super.key,
    required this.level,
    required this.heat,
  });

  final int level;
  final int heat;

  @override
  Widget build(BuildContext context) {
    final double progress = (heat % 1000) / 1000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.workspace_premium_rounded,
              size: 14,
              color: Color(0xffFFD54F),
            ),
            const SizedBox(width: 6),
            Text(
              "Lv.$level",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
            const Spacer(),
            Text(
              "${(progress * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                color: Colors.white.withOpacity(.7),
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: Colors.white.withOpacity(.08),
            valueColor: const AlwaysStoppedAnimation(
              Color(0xffFFD54F),
            ),
          ),
        ),
      ],
    );
  }
}