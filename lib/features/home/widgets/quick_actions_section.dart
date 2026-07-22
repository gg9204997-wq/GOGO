// Path: lib/features/home/widgets/quick_actions_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joojo_chat/features/home/models/couple_cv_model.dart';
import 'package:joojo_chat/features/home/models/leaderboard_item_model.dart';
import 'package:joojo_chat/features/home/providers/home_provider.dart';
import 'package:joojo_chat/features/home/widgets/couple_cv_card.dart';
import 'package:joojo_chat/features/home/widgets/feature_leaderboard_card.dart';
// 🌟 ميكانيزم الإصلاح: استدعاء شاشة الصدارة الموحدة لربط الأزرار حياً
import 'package:joojo_chat/features/home/pages/leaderboards_page.dart';

class QuickActionsSection extends ConsumerWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final celebrities = ref.watch(topCelebritiesProvider);
    final agencies = ref.watch(topAgenciesProvider);
    final families = ref.watch(topFamiliesProvider);

    const coupleData = CoupleCvModel(
      id: '0',
      partnerOneAvatar: '',
      partnerTwoAvatar: '',
      heartFrame: '',
      eventTitle: 'فاعلية الارتباط',
      lovePoints: 0,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 0.65,
        children: [

          /// 🌟 1. كارت المشاهير - حقن أمر النقر والفتح الفوري
          celebrities.when(
            data: (list) {
              return FeatureLeaderboardCard(
                item: LeaderboardItemModel(
                  id: 'celebrities',
                  title: 'المشاهير',
                  frameImage: '',
                  backgroundImage: '',
                  totalSupport: 0,
                  topUsers: list.map((e) => e.avatar).where((e) => e.isNotEmpty).toList(),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const LeaderboardsPage(
                        leaderboardType: 'celebrities',
                        pageTitle: 'لوحة صدارة المشاهير 🏆',
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const CardShimmerPlaceholder(),
            error: (err, _) => const CardShimmerPlaceholder(),
          ),

          /// 🌟 2. كارت أفضل الوكالات - حقن أمر النقر والفتح الفوري
          agencies.when(
            data: (list) {
              return FeatureLeaderboardCard(
                item: LeaderboardItemModel(
                  id: 'agencies',
                  title: 'أفضل الوكالات',
                  frameImage: '',
                  backgroundImage: '',
                  totalSupport: 0,
                  topUsers: list.map((e) => e.logo).where((e) => e.isNotEmpty).toList(),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const LeaderboardsPage(
                        leaderboardType: 'agencies',
                        pageTitle: 'ترتيب أفضل الوكالات 🏢',
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const CardShimmerPlaceholder(),
            error: (err, _) => const CardShimmerPlaceholder(),
          ),

          /// 🌟 3. كارت أفضل العائلات - حقن أمر النقر والفتح الفوري
          families.when(
            data: (list) {
              return FeatureLeaderboardCard(
                item: LeaderboardItemModel(
                  id: 'families',
                  title: 'أفضل العائلات',
                  frameImage: '',
                  backgroundImage: '',
                  totalSupport: 0,
                  topUsers: list.map((e) => e.familyLogo).where((e) => e.isNotEmpty).toList(),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const LeaderboardsPage(
                        leaderboardType: 'families',
                        pageTitle: 'ترتيب عمالقة العائلات 🛡️',
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const CardShimmerPlaceholder(),
            error: (err, _) => const CardShimmerPlaceholder(),
          ),

          /// 🌟 4. كارت الـ CV للمرتبطين - حقن أمر النقر والفتح الفوري
          CoupleCvCard(
            coupleData: coupleData,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const LeaderboardsPage(
                    leaderboardType: 'couple_cv',
                    pageTitle: 'سجلات فاعلية الارتباط 💕',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardShimmerPlaceholder extends StatelessWidget {
  const CardShimmerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .04),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
