import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_shadows.dart';
import 'package:joojo_chat/core/theme/app_sizes.dart';

abstract final class AppCardTheme {
  const AppCardTheme._();

  static CardThemeData get light => const CardThemeData(
        color: AppColors.cardLight,
        elevation: AppSizes.zero,
        margin: EdgeInsets.zero,
        shadowColor: AppColors.overlayDark,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusXL,
        ),
      );

  static CardThemeData get dark => const CardThemeData(
        color: AppColors.card,
        elevation: AppSizes.zero,
        margin: EdgeInsets.zero,
        shadowColor: AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusXL,
        ),
      );

  static BoxDecoration get roomDecoration => const BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.radiusXL,
        boxShadow: AppShadows.room,
      );

  static BoxDecoration get glassDecoration => BoxDecoration(
        color: AppColors.glassDark,
        borderRadius: AppRadius.radiusXL,
        border: Border.all(
          color: AppColors.overlayLight,
        ),
        boxShadow: AppShadows.glass,
      );

  static BoxDecoration get primaryDecoration => const BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppRadius.radiusXL,
        boxShadow: AppShadows.primaryGlow,
      );

  static BoxDecoration get diamondDecoration => const BoxDecoration(
        color: AppColors.diamond,
        borderRadius: AppRadius.radiusXL,
        boxShadow: AppShadows.diamondGlow,
      );

  static BoxDecoration get vipDecoration => const BoxDecoration(
        color: AppColors.vipGold,
        borderRadius: AppRadius.radiusXL,
        boxShadow: AppShadows.goldGlow,
      );

  static BoxDecoration get agencyDecoration => const BoxDecoration(
        color: AppColors.agency,
        borderRadius: AppRadius.radiusXL,
      );

  static BoxDecoration get familyDecoration => const BoxDecoration(
        color: AppColors.family,
        borderRadius: AppRadius.radiusXL,
      );

  static BoxDecoration get transparentDecoration => const BoxDecoration(
        color: AppColors.transparent,
        borderRadius: AppRadius.radiusXL,
      );
}
