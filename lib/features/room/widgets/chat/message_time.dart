import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTime extends StatelessWidget {
  const MessageTime({
    super.key,
    required this.date,
    this.color = Colors.white54,
    this.fontSize = 10,
    this.showIcon = false,
    this.always24Hour = true,
  });

  final DateTime date;
  final Color color;
  final double fontSize;
  final bool showIcon;
  final bool always24Hour;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat(
      always24Hour ? 'HH:mm' : 'hh:mm a',
    ).format(date);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Icon(
            Icons.access_time_rounded,
            size: fontSize + 2,
            color: color,
          ),
          const SizedBox(width: 3),
        ],
        Text(
          time,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}