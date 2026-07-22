// Path: lib/features/profile/pages/profile_page.dart

import 'package:flutter/material.dart';
import 'package:joojo_chat/features/profile/models/user_inventory_model.dart';
import 'package:joojo_chat/features/profile/widgets/profile_backpack_section.dart';
import 'package:joojo_chat/features/profile/widgets/profile_couple_section.dart';
import 'package:joojo_chat/features/profile/widgets/profile_header_section.dart';
import 'package:joojo_chat/features/profile/widgets/profile_stats_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _backpackTabController;

  // حقيبة ممتلكات شحن الحساب الحية الشاملة بالملي
  final UserInventoryModel myInventory = const UserInventoryModel(
    activeFrame: 'إطار التنين الأسطوري 🔥',
    activeRide: 'لامبورغيني نيون 🏎️',
    ownedItems: [
      'إطار التنين الأسطوري 🔥',
      'إطار نيون ملكي ⚡',
      'إطار الملك الياقوتي 💎',
      'لامبورغيني نيون 🏎️',
      'تنين اللهب الأسطوري 🐉',
      'فقاعة الهيبة الذهبية 💬',
      'فقاعة الشات الوردية 💬'
    ],
  );

  @override
  void initState() {
    super.initState();
    // تحكم ثلاثي التبويبات لحقيبة الممتلكات الداخلية (إطارات، استقراطيات، فقاعات)
    _backpackTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _backpackTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // تصفية محتويات الحقيبة داخلياً لكل تبويب برمجياً بالملي
    final ownedFrames = myInventory.ownedItems.where((e) => e.contains('إطار')).toList();
    final ownedRides = myInventory.ownedItems.where((e) => e.contains('لامبورغيني') || e.contains('تنين')).toList();
    final ownedBubbles = myInventory.ownedItems.where((e) => e.contains('فقاعة')).toList();

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. قسم رأس الحساب والأوسمة المطور والمنفصل
            ProfileHeaderSection(activeFrame: myInventory.activeFrame),
            const SizedBox(height: 16),

            // 2. قسم الشريك والعلاقات التفاعلي المضيء المنفصل
            const ProfileCoupleSection(),
            const SizedBox(height: 10),

            // 3. لوحة الانتماء للعائلات والوكالات والعدادات الرقمية المنفصلة
            const ProfileStatsSection(),
            const SizedBox(height: 20),

            // 4. حقيبة الممتلكات المتقدمة ثلاثية التصنيفات المجمعة بأزرار تفعيل ملمومة
            ProfileBackpackSection(
              tabController: _backpackTabController,
              ownedFrames: ownedFrames,
              ownedRides: ownedRides,
              ownedBubbles: ownedBubbles,
              activeFrame: myInventory.activeFrame,
              activeRide: myInventory.activeRide,
            ),
            const SizedBox(height: 120), // مسافة أمان لكي لا يختفي الكود تحت الكبسولة السفلية
          ],
        ),
      ),
    );
  }
}
