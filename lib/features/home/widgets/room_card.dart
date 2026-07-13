import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class RoomCard extends StatelessWidget {
  final String roomName;
  final String ownerName;
  final String coverImage;
  final String ownerAvatar;
  final String countryFlag;
  final int members;
  final bool isLive;
  final bool isVip;

  const RoomCard({
    super.key,
    required this.roomName,
    required this.ownerName,
    required this.coverImage,
    required this.ownerAvatar,
    required this.countryFlag,
    required this.members,
    this.isLive = true,
    this.isVip = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.radiusXxl,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [

          /// ===========================
          /// Cover
          /// ===========================

          Expanded(
            flex: 6,
            child: Stack(
              children: [

                Positioned.fill(
                  child: Image.asset(
                    coverImage,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.overlayDark,
                          AppColors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),                /// عدد الأعضاء
                Positioned(
                  top: AppSpacing.md,
                  left: AppSpacing.md,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.overlayDark,
                      borderRadius: AppRadius.radiusPill,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.remove_red_eye_outlined,
                          color: AppColors.white,
                          size: AppSizes.iconXs,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          members.toString(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// علم الدولة
                Positioned(
                  top: AppSpacing.md,
                  right: AppSpacing.md,
                  child: Text(
                    countryFlag,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),

                /// LIVE
                if (isLive)
                  Positioned(
                    bottom: AppSpacing.md,
                    left: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.voiceLive,
                        borderRadius: AppRadius.radiusPill,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.mic,
                            color: AppColors.white,
                            size: AppSizes.iconXs,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            "LIVE",
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),          /// ===========================
          /// معلومات الغرفة
          /// ===========================

          Expanded(
            flex: 4,
            child: Padding(
              padding: AppSpacing.card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    roomName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xs),

                  Text(
                    "دردشة • موسيقى • ألعاب",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [

                      CircleAvatar(
                        radius: AppSizes.avatarSm / 2,
                        backgroundImage: AssetImage(ownerAvatar),
                      ),

                      const SizedBox(width: AppSpacing.sm),

                      Expanded(
                        child: Text(
                          ownerName,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),

                      if (isVip)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.vipGold,
                            borderRadius: AppRadius.radiusPill,
                          ),
                          child: Text(
                            "VIP",
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                    ],
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}