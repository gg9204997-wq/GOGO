import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

class HomeRoomTabs extends StatefulWidget {
  const HomeRoomTabs({super.key});

  @override
  State<HomeRoomTabs> createState() => _HomeRoomTabsState();
}

class _HomeRoomTabsState extends State<HomeRoomTabs> {
  int selected = 0;

  final List<String> tabs = const [
    'الكل',
    'الشائعة',
    'الجديدة',
    'PK',
    'خاصة',
    'VIP',
    'عائلية',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ListView.separated(
        padding: AppSpacing.card,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: tabs.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final active = selected == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selected = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: active
                    ? AppColors.primary
                    : AppColors.card,
                borderRadius: AppRadius.radiusPill,
                border: Border.all(
                  color: active
                      ? AppColors.primary
                      : Colors.white10,
                ),
              ),
              child: Center(
                child: Text(
                  tabs[index],
                  style: AppTextStyles.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: active
                        ? FontWeight.bold
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}