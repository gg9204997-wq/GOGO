import 'package:flutter/material.dart';

class MemberRing extends StatelessWidget {
  const MemberRing({
    super.key,
    this.size = 34,
    this.isVip = false,
    this.isHost = false,
    required this.child,
  });

  final double size;
  final bool isVip;
  final bool isHost;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = isHost
        ? const [
            Color(0xffFFF8C5),
            Color(0xffFFD54F),
            Color(0xffFFB300),
            Color(0xffFFD54F),
          ]
        : isVip
            ? const [
                Color(0xffE1BEE7),
                Color(0xff9C6BFF),
                Color(0xff673AB7),
                Color(0xff9C6BFF),
              ]
            : const [
                Color(0xffF5F5F5),
                Color(0xffD6D6D6),
                Color(0xffBDBDBD),
                Color(0xffF5F5F5),
              ];

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(colors: colors),
        boxShadow: [
          BoxShadow(
            color: colors[1].withValues(alpha: .35),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: .20),
            ),
          ),
          child: ClipOval(
            child: child,
          ),
        ),
      ),
    );
  }
}