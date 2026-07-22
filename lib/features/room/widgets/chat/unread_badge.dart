import 'package:flutter/material.dart';

class UnreadBadge extends StatelessWidget {
  const UnreadBadge({
    super.key,
    required this.count,
    this.onTap,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.maxCount = 99,
    this.showZero = false,
    this.size = 22,
  });

  final int count;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final int maxCount;
  final bool showZero;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (count <= 0 && !showZero) {
      return const SizedBox.shrink();
    }

    final text =
        count > maxCount ? '$maxCount+' : count.toString();

    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        constraints: BoxConstraints(
          minWidth: size,
          minHeight: size,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(.35),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}