import 'package:flutter/material.dart';

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const Color neonPurple = Color(0xff8A5CFF);

    return Column(
      children: [
        // حاوية العائلة والوكالة
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xff0F1124),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xff00BFFF).withValues(alpha: 0.2), width: 1),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 15, 
                backgroundColor: Color(0xff1A1435), 
                child: Icon(Icons.shield_rounded, color: Color(0xff00BFFF), size: 16),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('عائلة: سلاطين العرب 🦅 [قائد العائلة]', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                    Text('الوكالة التابع لها: وكالة قصر العرب الماسية ✨', style: TextStyle(color: Colors.white30, fontSize: 8.5, fontFamily: 'Cairo')),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Color(0xff00BFFF), size: 16),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // لوحة العدادات الممتدة
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xff120D1F),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: neonPurple.withValues(alpha: 0.15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCountItem('المتابِعون', '14.2K'),
              Container(width: 0.8, height: 24, color: Colors.white10),
              _buildCountItem('المتابَعون', '320'),
              Container(width: 0.8, height: 24, color: Colors.white10),
              _buildCountItem('ثروة الماس 💎', '250K'),
              Container(width: 0.8, height: 24, color: Colors.white10),
              _buildCountItem('الزوار اليوم', '1,480'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCountItem(String label, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, fontFamily: 'Cairo')),
      ],
    );
  }
}
