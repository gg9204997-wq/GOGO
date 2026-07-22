import 'package:flutter/material.dart';

class SeatFrame extends StatelessWidget {
  const SeatFrame({
    super.key,
    required this.child,
    this.size = 82,
    this.borderColor = const Color(0xFFFFD54F),
    this.backgroundColor = const Color(0xFF1E1E2E),
    this.borderWidth = 3,
    this.showGlow = true,
    this.glowColor = const Color(0xFFFFD54F),
    this.padding = const EdgeInsets.all(4),
  });

  final Widget child;

  final double size;

  final Color borderColor;

  final Color backgroundColor;

  final double borderWidth;

  final bool showGlow;

  final Color glowColor;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: size,
        height: size,
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          boxShadow: showGlow
              ? [
                  BoxShadow(
                    color: glowColor.withOpacity(.35),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: ClipOval(
          child: child,
        ),
      ),
    );
  }
}

class VipSeatFrame extends StatelessWidget {
  const VipSeatFrame({
    super.key,
    required this.child,
    this.size = 86,
  });

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SeatFrame(
      size: size,
      borderColor: const Color(0xffFBC02D),
      glowColor: const Color(0xffFBC02D),
      backgroundColor: const Color(0xff2C1E00),
      borderWidth: 3.5,
      child: child,
    );
  }
}

class AdminSeatFrame extends StatelessWidget {
  const AdminSeatFrame({
    super.key,
    required this.child,
    this.size = 86,
  });

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SeatFrame(
      size: size,
      borderColor: Colors.redAccent,
      glowColor: Colors.redAccent,
      backgroundColor: const Color(0xff2B1010),
      child: child,
    );
  }
}