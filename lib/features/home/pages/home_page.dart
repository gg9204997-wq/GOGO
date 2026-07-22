// Path: lib/features/home/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/features/home/pages/chat_inbox_page.dart'; // 🌟 استدعاء شاشة صندوق الرسائل والوارد الجديدة حياً
import 'package:joojo_chat/features/home/pages/search_page.dart';
import 'package:joojo_chat/features/home/providers/home_provider.dart';
import 'package:joojo_chat/features/home/widgets/categories_bar.dart';
import 'package:joojo_chat/features/home/widgets/countries_bar.dart';
import 'package:joojo_chat/features/home/widgets/home_app_bar.dart';
import 'package:joojo_chat/features/home/widgets/home_banner.dart';
import 'package:joojo_chat/features/home/widgets/live_rooms_section.dart';
import 'package:joojo_chat/features/home/widgets/quick_actions_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String selectedCountry = 'مصر';
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    // 🎙️ الاستماع المباشر لدفق غرف البث الحية المفلترة بالدولة من قاعدة البيانات حياً بالملي
    final rooms = ref.watch(liveRoomsStreamProvider(selectedCountry));

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      // 🌟 ميكانيزم الإصلاح: تم حذف SafeArea هنا ليتكامل الرندر والأبعاد مع الـ NavigationShell وتعود أزرار التنقل السفلية حية وسريعة 
      body: RefreshIndicator(
        color: const Color(0xff8A5CFF),
        onRefresh: () async {
          ref.invalidate(liveRoomsStreamProvider(selectedCountry));
          ref.invalidate(topCelebritiesProvider);
          ref.invalidate(topAgenciesProvider);
          ref.invalidate(topFamiliesProvider);
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // مسافة أمان علوية مرنة لمنع تداخل العناوين تحت شريط أحداث الهدايا
            const SliverToBoxAdapter(child: SizedBox(height: 56)),

            /// 👑 AppBar الإمبراطوري مع تفعيل وضخ الكواباكس الحية لفتح الصفحات
            SliverToBoxAdapter(
              child: HomeAppBar(
                onSearchTap: () {
                  // الانتقال الفوري لصفحة البحث المفلترة بالسيرفر
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                onNotificationTap: () {
                  // 🌟 ميكانيزم الإصلاح: فتح واستدعاء صفحة الرسائل والوارد الجديدة فوراً بنقاوة لنسف شاشة الخطأ الزرقاء
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const ChatInboxPage(),
                    ),
                  );
                },
                onProfileTap: () => context.push('/profile'),
                onWalletTap: () => context.push('/wallet'),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),

            /// Banner الإعلاني (نجم الأسبوع)
            const SliverToBoxAdapter(
              child: HomeBanner(
                banners: [],
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 18),
            ),

            /// Leaderboards (بطاقات الصدارة الأربعة نيون الملونة)
            const SliverToBoxAdapter(
              child: QuickActionsSection(),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 18),
            ),

            /// 🌍 4. شريط أعلام غرف الدول الدائري والفلترة اللحظية بالسيرفر عند الضغط
            SliverToBoxAdapter(
              child: CountriesBar(
                countries: const [],
                onCountrySelected: (code) {
                  setState(() {
                    switch (code) {
                      case 'eg':
                        selectedCountry = 'مصر';
                        break;
                      case 'sa':
                        selectedCountry = 'السعودية';
                        break;
                      case 'ae':
                        selectedCountry = 'الإمارات';
                        break;
                      case 'kw':
                        selectedCountry = 'الكويت';
                        break;
                      case 'iq':
                        selectedCountry = 'العراق';
                        break;
                      case 'jo':
                        selectedCountry = 'الأردن';
                        break;
                      case 'lb':
                        selectedCountry = 'لبنان';
                        break;
                      case 'ma':
                        selectedCountry = 'المغرب';
                        break;
                      case 'dz':
                        selectedCountry = 'الجزائر';
                        break;
                      default:
                        selectedCountry = 'مصر';
                    }
                  });
                },
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),

            /// 🪔 5. شريط التبويبات الفئات الثلاثي المضاء (الشائعة، المتابعة، الجديدة)
            SliverToBoxAdapter(
              child: CategoriesBar(
                selectedTab: selectedTab,
                onTabChanged: (value) {
                  setState(() {
                    selectedTab = value;
                  });
                },
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),              

            /// 🎙️ 6. شبكة الغرف الصوتية الحقيقية المقروءة والمفلترة من الـ Live Stream لـ Supabase بالملي
            rooms.when(
              data: (list) {
                final displayRooms = [...list];

                // ميكانيزم تصفية وفرز الغرف حياً حسب التبويب النشط
                switch (selectedTab) {
                  // الشائعة
                  case 0:
                    displayRooms.sort(
                      (a, b) => b.heat.compareTo(a.heat),
                    );
                    break;

                  // المتابعة
                  case 1:
                    displayRooms.sort(
                      (a, b) => b.activeUsers.compareTo(
                        a.activeUsers,
                      ),
                    );
                    break;

                  // الجديدة
                  case 2:
                    displayRooms.sort(
                      (a, b) => b.createdAt.compareTo(
                        a.createdAt,
                      ),
                    );
                    break;
                }

                return LiveRoomsSection(
                  rooms: displayRooms,
                );
              },

              loading: () {
                return const LiveRoomsSection(
                  rooms: [],
                  isLoading: true,
                );
              },

              error: (error, stack) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                    ),
                    child: Center(
                      child: Text(
                        'خطأ اتصال غرف السيرفر: $error',
                        style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Cairo',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 120),
            ),
          ],
        ),
      ),
    );
  }
}
