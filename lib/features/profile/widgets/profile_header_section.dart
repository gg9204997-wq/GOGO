import 'package:flutter/material.dart';

class ProfileHeaderSection extends StatelessWidget {
  final String activeFrame;

  const ProfileHeaderSection({
    required this.activeFrame,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color neonPurple = Color(0xff8A5CFF);
    const Color goldColor = Color(0xffFFD700);

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff4B0E5A), Color(0xff120D1F)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: -35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: neonPurple.withValues(alpha: 0.35), blurRadius: 16, spreadRadius: 2),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 34,
                    backgroundColor: Color(0xff1A1435),
                    backgroundImage: NetworkImage('https://dicebear.com'),
                  ),
                  if (activeFrame.isNotEmpty)
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: goldColor.withValues(alpha: 0.7), width: 2.2),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 45),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'الملك أسامة المصري',
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
            ),
            SizedBox(width: 4),
            Icon(Icons.verified_rounded, color: Color(0xff00BFFF), size: 16),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          'ID: 88877799',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBadgeItem('VIP 8', const LinearGradient(colors: [goldColor, Colors.orange])),
            const SizedBox(width: 6),
            _buildBadgeItem('Lv.45', const LinearGradient(colors: [neonPurple, Color(0xff6C38FF)])),
            const SizedBox(width: 6),
            _buildBadgeItem('الملياردير 💰', const LinearGradient(colors: [Color(0xff00FFCC), Color(0xff0099FF)])),
            const SizedBox(width: 6),
            _buildBadgeItem('داعم الأسبوع 🏆', const LinearGradient(colors: [Color(0xffFF1493), Color(0xffFF69B4)])),
          ],
        ),
      ],
    );
  }

  Widget _buildBadgeItem(String text, Gradient gradient) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900, fontFamily: 'Cairo')),
    );
  }
}
