// Path: lib/features/home/widgets/home_app_bar.dart

import 'dart:math'; // 🌟 مكتبة الحسابات الرياضية لتوليد الآيدي العشوائي الـ 8 أرقام حياً
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joojo_chat/features/auth/providers/auth_provider.dart';

class HomeAppBar extends ConsumerWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onWalletTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;

  const HomeAppBar({
    super.key,
    this.onProfileTap,
    this.onWalletTap,
    this.onSearchTap,
    this.onNotificationTap,
  });

  /// 🎲 دالة ذكية لتوليد آيدي عشوائي مثبت من 8 أرقام بناءً على الـ Hash Code الخاص بـ User Id لمنع تغيره عند الـ Hot Restart
  String _generateRandom8DigitId(String userId) {
    if (userId.isEmpty) return '00000000';
    final int seed = userId.hashCode;
    final Random random = Random(seed);
    final int min = 10000000;
    final int max = 99999999;
    final int randomId = min + random.nextInt(max - min);
    return randomId.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      loading: () => const SizedBox(height: 70),
      error: (_, __) => const SizedBox(height: 70),
      data: (user) {
        final avatar = user?.avatar?.isNotEmpty == true
            ? user!.avatar!
            : 'https://ui-avatars.com';

        // 🌟 ميكانيزم التبديل الذكي: لو المستخدم مميز وعنده customId يعرضه، لو مستخدم عادي يولد له 8 أرقام عشوائي فريد ومثبت
        final String currentDbId = user?.userId ?? '';
        final String displayedId = currentDbId.isNotEmpty ? currentDbId : _generateRandom8DigitId(user?.id ?? '');

        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
          child: Row(
            children: [
              GestureDetector(
                onTap: onProfileTap,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xffFFD700),
                          width: 1.5,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff1A1435),
                        backgroundImage: CachedNetworkImageProvider(avatar),
                      ),
                    ),
                    Positioned(
                      bottom: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff8A5CFF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${user?.level ?? 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user?.name ?? 'جوجو',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (user?.verified == true)
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.verified,
                            color: Colors.lightBlue,
                            size: 14,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      // 🌟 طباعة الآيدي الـ 8 أرقام المتغير حياً على الشاشة بنقاء كامل كطلبك بالظبط
                      Text(
                        'ID : $displayedId',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .5),
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'VIP ${user?.vipLevel ?? 0}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              GestureDetector(
                onTap: onWalletTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff16112C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.diamond,
                        color: Colors.cyan,
                        size: 15,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${user?.diamonds ?? 0}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),

              GestureDetector(
                onTap: onSearchTap,
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),

              GestureDetector(
                onTap: onNotificationTap,
                // 🌟 تم تصحيح الـ const هنا لحل تحذيرات الـ Lints القياسية بالملي
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
