import 'package:flutter/material.dart';

class MessageReactionBar extends StatelessWidget {
  const MessageReactionBar({
    super.key,
    required this.reactions,
    this.onTap,
    this.spacing = 6,
  });

  /// مثال:
  /// {
  ///   "❤️":12,
  ///   "👍":5,
  ///   "😂":3,
  /// }
  final Map<String, int> reactions;

  final ValueChanged<String>? onTap;

  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (reactions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: reactions.entries.map((entry) {
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => onTap?.call(entry.key),
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 180,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff2A3147),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white10,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  entry.value.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}