import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

class HomeCategories extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const HomeCategories({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const _categories = [
    ('🔥', 'الكل'),
    ('🎵', 'موسيقى'),
    ('🎮', 'ألعاب'),
    ('💘', 'تعارف'),
    ('👨‍👩‍👧', 'عائلة'),
    ('🎤', 'غناء'),
    ('😂', 'ترفيه'),
    ('⭐', 'VIP'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
        ),
        itemCount: _categories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final item = _categories[index];

          final selected = index == selectedIndex;

          return InkWell(
            borderRadius: AppRadius.radiusPill,
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary
                    : AppColors.surface,
                borderRadius: AppRadius.radiusPill,
              ),
              child: Row(
                children: [
                  Text(
                    item.$1,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.$2,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: selected
                          ? AppColors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}