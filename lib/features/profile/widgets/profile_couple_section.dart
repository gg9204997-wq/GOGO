import 'package:flutter/material.dart';

class ProfileCoupleSection extends StatelessWidget {
  const ProfileCoupleSection({super.key});

  @override
  Widget build(BuildContext context) {
    const Color pinkHeart = Color(0xffFF1493);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff140B24),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: pinkHeart.withValues(alpha: 0.25), width: 1),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(width: 32, height: 32, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.pink)),
              const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://dicebear.com')),
              Icon(Icons.favorite_rounded, color: pinkHeart.withValues(alpha: 0.8), size: 12),
            ],
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الشريك العاطفي: الأميرة نور ❤️', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                Text('نقاط الحب والارتباط المشترك: 75,000 نغمة', style: TextStyle(color: Colors.white30, fontSize: 8.5, fontFamily: 'Cairo')),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: pinkHeart, size: 16),
        ],
      ),
    );
  }
}
