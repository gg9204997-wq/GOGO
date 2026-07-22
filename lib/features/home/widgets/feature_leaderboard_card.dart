// Path: lib/features/home/widgets/feature_leaderboard_card.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/home/models/leaderboard_item_model.dart';

class FeatureLeaderboardCard extends StatelessWidget {
  final LeaderboardItemModel item;
  final VoidCallback onTap;

  const FeatureLeaderboardCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ميكانيزم فرز الألوان النيون الذكي القياسي بمشروعك بناءً على العناوين حياً
    final Color accentColor = item.title.contains('مشاهير') || item.title.contains('المشاهير')
        ? const Color(0xffFF8C00)
        : item.title.contains('وكالات') || item.title.contains('الوكالات')
            ? const Color(0xff00BFFF)
            : const Color(0xff2ECC71);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: item.backgroundImage.isNotEmpty
              ? DecorationImage(
                  image: CachedNetworkImageProvider(
                    item.backgroundImage,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
          gradient: item.backgroundImage.isEmpty
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accentColor.withValues(alpha: .18),
                    const Color(0xff161022),
                  ],
                )
              : null,
          border: Border.all(
            color: accentColor.withValues(alpha: .45),
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: .10),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          // 🌟 ميكانيزم الإصلاح: تقليص البادينج الداخلي لـ 4 ليتسع الكارت ويمسح الـ Bottom Overflow تماماً
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 10, // 🌟 مقاس عنوان الكارت المتناسق
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4), // 🌟 تقليص المسافة البينية الرأسية

              // 🌟 استدعاء دالة رص أفاتارات الأوائل الأصلية والمحسنة هندسياً
              _buildOverlappingAvatars(accentColor),

              const SizedBox(height: 4), // 🌟 تقليص المسافة البينية الرأسية

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .35),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: accentColor.withValues(alpha: .30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'عرض الكل',
                      style: TextStyle(
                        color: accentColor,
                        fontFamily: 'Cairo',
                        fontSize: 7.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 1),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: accentColor,
                      size: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🌟 دالة بناء ورص الأفاتارات المتداخلة (تمت تصفية مساحاتها الرأسية والأفقية لنسف الخطوط الحمراء)
  Widget _buildOverlappingAvatars(Color themeColor) {
    final displayUsers = item.topUsers.where((e) => e.isNotEmpty).toList();
    final int displayCount = displayUsers.length > 3 ? 3 : displayUsers.length;

    if (displayCount == 0) {
      return const CircleAvatar(
        radius: 8, // 🌟 تقليص القطر ليتناسب هندسياً مع الكارت
        backgroundColor: Colors.white10,
        child: Icon(
          Icons.person,
          color: Colors.white54,
          size: 9,
        ),
      );
    }

    return SizedBox(
      // 🌟 تصفية الأبعاد أفقياً ورأسياً لمنع الـ Overflow بالملي
      width: 32 + (displayCount - 1) * 9.0,
      height: 18,
      child: Stack(
        children: List.generate(
          displayCount,
          (index) {
            return Positioned(
              left: index * 9.0, // 🌟 إحداثيات مرنة تمنع التمدد الزائد خارج حافة الكارت
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xff090514),
                    width: 0.8, // 🌟 حماية ونقاوة خط الإطار الفاصل
                  ),
                ),
                child: CircleAvatar(
                  radius: 8, // 🌟 نصف القطر الموزون والمستقر 100%
                  backgroundColor: const Color(0xff2A2A3D),
                  backgroundImage: displayUsers[index].isNotEmpty
                      ? CachedNetworkImageProvider(displayUsers[index])
                      : null,
                  child: displayUsers[index].isEmpty
                      ? const Icon(
                          Icons.person,
                          color: Colors.white70,
                          size: 9,
                        )
                      : null,
                  onBackgroundImageError: (_, __) {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
