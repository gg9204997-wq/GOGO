import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_spacing.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    required this.currentIndex,
    required this.totalCount,
    super.key,
  });

  final int currentIndex;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        totalCount,
        _buildIndicator,
      ),
    );
  }

  Widget _buildIndicator(int index) {
    final bool isActive = index == currentIndex;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: AppSpacing.xs,
      width: isActive ? AppSpacing.xxl : AppSpacing.xs,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.textHint,
        borderRadius: BorderRadius.circular(AppSpacing.xs),
      ),
    );
  }
}
