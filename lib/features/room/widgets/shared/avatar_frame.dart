import 'package:flutter/material.dart';

class AvatarFrame extends StatelessWidget {
  const AvatarFrame({
    super.key,
    required this.child,
    this.size = 60,
    this.borderColor = const Color(0xFFFFD54F),
    this.backgroundColor = Colors.transparent,
    this.borderWidth = 3,
    this.padding = 3,
    this.boxShadow = const [
      BoxShadow(
        color: Color(0x55FFD54F),
        blurRadius: 12,
        spreadRadius: 1,
      ),
    ],
  });

  final Widget child;
  final double size;
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;
  final double padding;
  final List<BoxShadow> boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        boxShadow: boxShadow,
      ),
      child: ClipOval(
        child: child,
      ),
    );
  }
}