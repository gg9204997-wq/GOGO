// Path: lib/features/explore/pages/explore_page.dart

import 'package:flutter/material.dart';
import 'package:joojo_chat/features/explore/models/explore_post_model.dart';
import 'package:joojo_chat/features/explore/widgets/explore_post_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int selectedCategoryIndex = 0; // 0: الكل، 1: طرب، 2: ألعاب، 3: مسابقات

  // 💡 يوميات ومنشورات وهمية فخمة ليعمل معها الألبوم التفاعلي واللايكات لايف
  final List<ExplorePostModel> mockPosts = [
    const ExplorePostModel(
      id: 'post_1',
      username: 'الملك أسامة 👑',
      userAvatar: 'https://dicebear.com',
      userLevel: 28,
      vipLevel: 8,
      contentText: 'أهلاً بكم في عالم جوجو شات الفخم! نتمنى للجميع سهرات ممتعة داخل غرف البث الصوتي المباشر الليلة 💜🚀',
      postImage: '', 
      likesCount: 124,
      commentsCount: 42,
      isLikedByMe: true,
    ),
    const ExplorePostModel(
      id: 'post_2',
      username: 'الأميرة نور 🌟',
      userAvatar: 'https://dicebear.com',
      userLevel: 15,
      vipLevel: 3,
      contentText: 'جمعة مباركة على أحلى عائلة وأصدقاء! شاركونا اليوم في مسابقة أكياس الحظ الكبرى بالمنصة وسجلوا وكالاتكم 🎁✨',
      postImage: '',
      likesCount: 86,
      commentsCount: 19,
      isLikedByMe: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const Color purpleNeon = Color(0xff8A5CFF);

    return Scaffold(
      backgroundColor: const Color(0xff090514), // الالتزام التام بالخلفية الملكية الموحدة للمشروع
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. الجزء العلوي: لوحة وعنوان شاشة الاستكشاف الفخمة
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'استكشف المنصة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),

            // 2. كبسولة الفعاليات العريضة والمضاءة بالنيون في أعلى شاشة الاستكشاف بالملي
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff3E1360), Color(0xff160B2D)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: purpleNeon.withValues(alpha: 0.3)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('لوحة الفعاليات الكبرى 🏆', style: TextStyle(color: Color(0xffFFD700), fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                        SizedBox(height: 2),
                        Text('انضم الآن لأقوى تحديات الوكالات والعائلات لهذا الأسبوع!', style: TextStyle(color: Colors.white70, fontSize: 10.5, fontFamily: 'Cairo')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // 3. شريط كبسولات تصنيفات البث الذكية المستديرة (تطابق سيمترية الرئيسية بالملي)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCategoryTab('كل اليوميات', 0, Icons.blur_on_rounded, purpleNeon),
                    const SizedBox(width: 8),
                    _buildCategoryTab('طرب وغناء', 1, Icons.music_note_rounded, const Color(0xff00BFFF)),
                    const SizedBox(width: 8),
                    _buildCategoryTab('غرف ألعاب', 2, Icons.sports_esports_rounded, const Color(0xffFF4500)),
                    const SizedBox(width: 8),
                    _buildCategoryTab('مسابقات', 3, Icons.emoji_events_rounded, const Color(0xffFFD700)),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),

            // 4. ألبوم رص منشورات ويوميات الأعضاء التفاعلية الحية بالملي
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final postItem = mockPosts[index];
                    return ExplorePostCard(
                      post: postItem,
                      onLikeTap: () {
                        // تفعيل ميكانيزم الإعجاب وزيادة العدادات لاحقاً
                      },
                    );
                  },
                  childCount: mockPosts.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String label, int index, IconData icon, Color activeColor) {
    final bool isSelected = selectedCategoryIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedCategoryIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff211440) : const Color(0xff120D1F),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeColor.withValues(alpha: 0.6) : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? activeColor : Colors.white60, size: 13),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white60,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
