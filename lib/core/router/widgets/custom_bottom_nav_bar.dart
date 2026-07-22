// lib/core/widgets/custom_bottom_nav_bar.dart
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final VoidCallback onMicPressed;

  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onTabSelected,
    required this.onMicPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color neonPurple = Color(0xff8A5CFF);
    final Size screenSize = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70, 
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xff120A2A),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_rounded, 'الرئيسية'),
              _buildNavItem(1, Icons.explore_rounded, 'استكشف'),
              const SizedBox(width: 52), 
              // 🛍️ تم تغيير الأيقونة من Icons.forum_rounded إلى Icons.shopping_bag_rounded وتغيير النص إلى المتجر ليفتح صفحة الشوب
              _buildNavItem(2, Icons.shopping_bag_rounded, 'المتجر'),
              _buildNavItem(3, Icons.person_rounded, 'حسابي'),
            ],
          ),
        ),
        Positioned(
          bottom: 30, 
          left: (screenSize.width / 2) - 26,
          child: GestureDetector(
            onTap: onMicPressed,
            child: Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xffA85CFF), Color(0xff8A5CFF)],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                ),
                boxShadow: [BoxShadow(color: neonPurple.withValues(alpha: 0.45), blurRadius: 12, spreadRadius: 2)],
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: const Icon(Icons.mic_rounded, color: Colors.white, size: 24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: SizedBox(
        width: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, 
          children: [
            Icon(icon, color: isSelected ? const Color(0xff8A5CFF) : Colors.white38, size: 22),
            const SizedBox(height: 2), 
            Text(
              label, 
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontSize: 9.5, fontFamily: 'Cairo'),
            ),
          ],
        ),
      ),
    );
  }
}
