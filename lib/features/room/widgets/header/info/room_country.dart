import 'package:flutter/material.dart';

class RoomCountry extends StatelessWidget {
  const RoomCountry({
    super.key,
    required this.countryName,
    this.flag = "🌍",
    this.showArrow = false,
  });

  final String? countryName;
  final String flag;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(.14),
            Colors.white.withOpacity(.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(.10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            flag,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),

          const SizedBox(width: 6),

          Text(
            countryName?.isNotEmpty == true
                ? countryName!
                : "Global",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),

          if (showArrow) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: Colors.white70,
            ),
          ],
        ],
      ),
    );
  }
}