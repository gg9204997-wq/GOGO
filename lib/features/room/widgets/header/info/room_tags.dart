import 'package:flutter/material.dart';

class RoomTags extends StatelessWidget {
  const RoomTags({
    super.key,
    required this.tags,
    this.maxVisible = 4,
  });

  final List<String> tags;
  final int maxVisible;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    final visibleTags = tags.take(maxVisible).toList();

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final tag in visibleTags)
          _TagChip(
            text: tag,
            color: _color(tag),
            icon: _icon(tag),
          ),
      ],
    );
  }

  static Color _color(String tag) {
    switch (tag.toLowerCase()) {
      case "music":
        return const Color(0xffAB47BC);

      case "singing":
        return const Color(0xffEC407A);

      case "games":
        return const Color(0xff42A5F5);

      case "fun":
        return const Color(0xffFFA726);

      case "vip":
        return const Color(0xffFFD54F);

      case "arabic":
        return const Color(0xff66BB6A);

      default:
        return const Color(0xff8D6E63);
    }
  }

  static IconData _icon(String tag) {
    switch (tag.toLowerCase()) {
      case "music":
        return Icons.music_note_rounded;

      case "singing":
        return Icons.mic_rounded;

      case "games":
        return Icons.sports_esports_rounded;

      case "fun":
        return Icons.sentiment_very_satisfied_rounded;

      case "vip":
        return Icons.workspace_premium_rounded;

      case "arabic":
        return Icons.public_rounded;

      default:
        return Icons.sell_rounded;
    }
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.text,
    required this.color,
    required this.icon,
  });

  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: .25),
            color.withValues(alpha: .12),
          ],
        ),
        border: Border.all(
          color: color.withValues(alpha: .45),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .20),
            blurRadius: 8,
          ),
        ],
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