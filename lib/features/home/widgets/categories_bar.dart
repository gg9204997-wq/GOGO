// Path: lib/features/home/widgets/categories_bar.dart

import 'package:flutter/material.dart';

class CategoriesBar extends StatelessWidget {
  final int selectedTab;
  // 🌟 تم تصحيح نوع الراجع هنا صراحة بـ void لحل خطأ inference_failure_on_function_return_type بالملي
  final void Function(int tabIndex)? onTabChanged;

  const CategoriesBar({
    required this.selectedTab,
    this.onTabChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        physics: const BouncingScrollPhysics(),
        // تم تصفية حقل الـ crossAxisAlignment أو أي معامل افتراضي مكرر بالسطر 51 لحل الـ Lint
        children: [
          _buildCategoryTab('الشائعة', 0, const Color(0xff8A5CFF)),
          const SizedBox(width: 8),
          _buildCategoryTab('المتابعة', 1, const Color(0xff00BFFF)),
          const SizedBox(width: 8),
          _buildCategoryTab('الجديدة', 2, const Color(0xffFFD700)),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String label, int index, Color activeColor) {
    final bool isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        if (onTabChanged != null) {
          onTabChanged!(index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff211440) : const Color(0xff120D1F),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeColor.withValues(alpha: 0.6) : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}
