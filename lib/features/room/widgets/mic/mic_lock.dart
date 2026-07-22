import 'package:flutter/material.dart';

class MicLock extends StatelessWidget {
  const MicLock({
    super.key,
    this.locked = false,
    this.size = 22,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  final bool locked;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: size + 12,
        height: size + 12,
        decoration: BoxDecoration(
          color: backgroundColor ??
              (locked
                  ? Colors.red.withValues(alpha: .15)
                  : Colors.green.withValues(alpha: .15)),
          shape: BoxShape.circle,
          border: Border.all(
            color: locked
                ? Colors.red
                : Colors.green,
          ),
        ),
        child: Icon(
          locked
              ? Icons.lock_rounded
              : Icons.lock_open_rounded,
          size: size,
          color: color ??
              (locked
                  ? Colors.red
                  : Colors.green),
        ),
      ),
    );
  }
}