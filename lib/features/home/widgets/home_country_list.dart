import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

class HomeCountryList extends StatelessWidget {
  const HomeCountryList({super.key});

  static const _countries = [
    ('🌍', 'الكل'),
    ('🇪🇬', 'مصر'),
    ('🇸🇦', 'السعودية'),
    ('🇦🇪', 'الإمارات'),
    ('🇰🇼', 'الكويت'),
    ('🇶🇦', 'قطر'),
    ('🇧🇭', 'البحرين'),
    ('🇴🇲', 'عمان'),
    ('🇮🇶', 'العراق'),
    ('🇯🇴', 'الأردن'),
    ('🇱🇧', 'لبنان'),
    ('🇸🇾', 'سوريا'),
    ('🇾🇪', 'اليمن'),
    ('🇩🇿', 'الجزائر'),
    ('🇲🇦', 'المغرب'),
    ('🇹🇳', 'تونس'),
    ('🇱🇾', 'ليبيا'),
    ('🇸🇩', 'السودان'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.separated(
        padding: AppSpacing.card,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _countries.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final item = _countries[index];

          return InkWell(
            borderRadius: AppRadius.radiusPill,
            onTap: () {},
            child: Ink(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: index == 0
                    ? AppColors.primary
                    : AppColors.card,
                borderRadius: AppRadius.radiusPill,
              ),
              child: Row(
                children: [
                  Text(
                    item.$1,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    item.$2,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
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