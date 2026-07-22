import 'package:flutter/material.dart';

class MessageLevel extends StatelessWidget {
  const MessageLevel({
    super.key,
    required this.level,
    this.size = 22,
    this.showIcon = true,
  });

  final int level;
  final double size;
  final bool showIcon;

  Color get _start {
    if (level >= 100) return const Color(0xffFF1744);
    if (level >= 80) return const Color(0xffFF9800);
    if (level >= 60) return const Color(0xff9C27B0);
    if (level >= 40) return const Color(0xff3F51B5);
    if (level >= 20) return const Color(0xff03A9F4);
    return const Color(0xff4CAF50);
  }

  Color get _end {
    if (level >= 100) return const Color(0xffFFD700);
    if (level >= 80) return const Color(0xffFFC107);
    if (level >= 60) return const Color(0xffE040FB);
    if (level >= 40) return const Color(0xff536DFE);
    if (level >= 20) return const Color(0xff00BCD4);
    return const Color(0xff8BC34A);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            _start,
            _end,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: _start.withOpacity(.35),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon)
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(
                Icons.workspace_premium,
                color: Colors.white,
                size: 13,
              ),
            ),
          Text(
            "Lv.$level",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}