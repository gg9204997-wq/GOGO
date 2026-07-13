import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

class HomeSearch extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onFilter;
  final ValueChanged<String>? onChanged;

  const HomeSearch({
    super.key,
    required this.controller,
    this.onFilter,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.radiusPill,
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textHint,
                  size: AppSizes.iconMd,
                ),
                hintText: 'ابحث عن غرفة...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textHint,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        InkWell(
          onTap: onFilter,
          borderRadius: AppRadius.radiusPill,
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: AppRadius.radiusPill,
            ),
            child: const Icon(
              Icons.tune,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}