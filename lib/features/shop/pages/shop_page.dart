// Path: lib/features/shop/pages/shop_page.dart

import 'package:flutter/material.dart';
import 'package:joojo_chat/features/shop/models/aristocracy_bundle_model.dart';
import 'package:joojo_chat/features/shop/models/entrance_effect_model.dart';
import 'package:joojo_chat/features/shop/models/store_item_model.dart';
import 'package:joojo_chat/features/shop/widgets/aristocracy_bundle_card.dart';
import 'package:joojo_chat/features/shop/widgets/entrance_effect_card.dart';
import 'package:joojo_chat/features/shop/widgets/store_item_card.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int selectedCategoryIndex = 0; // 0: VIP, 1: إطارات, 2: فقاعات, 3: تأثيرات الدخول, 4: الباقات الملكية
  int userDiamondsWallet = 12450; // محفظة الجواهر لتجربة الخصم والشراء الفوري

  // مصفوفة منتجات المتجر المعتمدة تماشياً مع قاعدة البيانات
  final List<StoreItemModel> mockStoreItems = [
    const StoreItemModel(
      id: 'vip_1',
      title: 'تاج الـ VIP الملكي 👑',
      category: 'vip',
      imageUrl: '', 
      price: 5000,
      requiredLevel: 10,
      isNew: true,
    ),
    const StoreItemModel(
      id: 'frame_1',
      title: 'إطار التنين المتوهج 🔥',
      category: 'frame',
      imageUrl: '',
      price: 3500,
      requiredLevel: 15,
      isNew: true,
    ),
    const StoreItemModel(
      id: 'frame_2',
      title: 'إطار نيون ملكي أزرق ⚡',
      category: 'frame',
      imageUrl: '',
      price: 2000,
      requiredLevel: 5,
      isNew: false,
    ),
    const StoreItemModel(
      id: 'bubble_1',
      title: 'فقاعة الشات الوردية 💬',
      category: 'bubble',
      imageUrl: '',
      price: 1200,
      requiredLevel: 1,
      isNew: false,
    ),
  ];

  // مصفوفة الاستقراطيات وبنرات الدخول الملكية المجهزة للمنصة بالملي
  final List<EntranceEffectModel> mockEntranceEffects = [
    const EntranceEffectModel(
      id: 'car_1',
      title: 'لامبورغيني نيون مشعة 🏎️',
      effectUrl: '',
      category: 'car',
      price: 25000,
      vipLevelRequired: 5,
      isAnimated: true,
    ),
    const EntranceEffectModel(
      id: 'car_2',
      title: 'تنين اللهب الأسطوري 🐉',
      effectUrl: '',
      category: 'car',
      price: 50000,
      vipLevelRequired: 8,
      isAnimated: true,
    ),
    const EntranceEffectModel(
      id: 'banner_1',
      title: 'بنر دخول ملكي عريض 👑',
      effectUrl: '',
      category: 'banner',
      price: 15000,
      vipLevelRequired: 4,
      isAnimated: true,
    ),
  ];

  // 🌟 مصفوفة الباقات الأرستقراطية الملكية الكاملة المضافة حديثاً للتبويب الخامس بالملي
  final List<AristocracyBundleModel> mockAristocracyBundles = [
    const AristocracyBundleModel(
      id: 'bundle_emperor',
      title: 'حزمة الإمبراطور الأسطورية 👑',
      price: 99000,
      vipLevelRequired: 10,
      frameName: 'إطار العرش المذهب',
      effectName: 'طائرة نفاثة نيون خارقة ✈️',
      bannerName: 'بنر الإمبراطور الصاعق ⚡',
      bubbleName: 'فقاعة الهيبة الذهبية 💬',
    ),
    const AristocracyBundleModel(
      id: 'bundle_knight',
      title: 'حزمة الفارس النيوني ⚔️',
      price: 45000,
      vipLevelRequired: 6,
      frameName: 'إطار السيف الأرجواني',
      effectName: 'لامبورغيني البرق المشع 🏎️',
      bannerName: 'بنر ترحيب الفرسان الملكي',
      bubbleName: 'فقاعة الشات النيوني 💬',
    ),
  ];

  /// دالة الشراء الفوري واقتطاع الجواهر الذكية مع التحقق من الرصيد والخصم الفعلي بالملي
  void _executePurchaseProcess({required String title, required int price}) {
    if (userDiamondsWallet < price) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xff120D1F),
          title: const Text('رصيد غير كافٍ ❌', style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 16)),
          content: Text('نعتذر منك، رصيدك من الجواهر لا يكفي لإتمام شراء $title. يرجى الشحن أولاً.', style: const TextStyle(color: Colors.white60, fontFamily: 'Cairo', fontSize: 13)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('حسناً', style: TextStyle(color: Color(0xffA277FF), fontFamily: 'Cairo')),
            )
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff120D1F),
        title: const Text('تأكيد عملية الشراء 🛒', style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 16)),
        content: Text('هل أنت متأكد من رغبتك في شراء "$title" واقتطاع $price جوهرة من محفظتك؟', style: const TextStyle(color: Colors.white60, fontFamily: 'Cairo', fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey, fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff6C38FF)),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                userDiamondsWallet -= price;
              });
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('🎉 مبروك! تم امتلاك "$title" بنجاح واقتطاع السعر من المحفظة!', style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                  backgroundColor: const Color(0xff211440),
                ),
              );
            },
            child: const Text('تأكيد الشراء', style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 12)),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // تصفية منتجات المتجر العادية بناءً على فئة زر التبويب المختار
    final filteredItems = mockStoreItems.where((item) {
      if (selectedCategoryIndex == 0) return item.category == 'vip';
      if (selectedCategoryIndex == 1) return item.category == 'frame';
      return item.category == 'bubble';
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xff090514), 
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. الجزء العلوي: عنوان المتجر ومحفظة الجواهر المضيئة الحية المحدثة بالملي
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'متجر المنصة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xff16112C),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xff7A4DFF).withValues(alpha: 0.35)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.diamond_rounded, color: Color(0xff00FFFF), size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '$userDiamondsWallet', // عرض الرصيد الحي المتغير ليتفاعل مع أزرار الشراء الفورية
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. شريط فئات المتجر الأفقي المضاء (5 أزرار انسيابية بالملي)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 38,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCategoryTab('شارات VIP', 0, Icons.workspace_premium_rounded, const Color(0xffFFD700)),
                    const SizedBox(width: 8),
                    _buildCategoryTab('إطارات الحساب', 1, Icons.stars_rounded, const Color(0xff00BFFF)),
                    const SizedBox(width: 8),
                    _buildCategoryTab('فقاعات الشات', 2, Icons.chat_bubble_rounded, const Color(0xffFF1493)),
                    const SizedBox(width: 8),
                    _buildCategoryTab('تأثيرات الدخول', 3, Icons.bolt_rounded, const Color(0xffFF8C00)),
                    const SizedBox(width: 8),
                    _buildCategoryTab('الباقات الملكية', 4, Icons.military_tech_rounded, const Color(0xffFFD700)),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),

            // 3. شبكة عرض المنتجات وتفعيل دوال الشراء التفاعلية الحقيقية بالملي
            _buildStoreGridContext(filteredItems),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreGridContext(List<StoreItemModel> items) {
    // ميكانيزم الإصلاح: التحقق من التبويب المختار أولاً لتحديد طول المصفوفة الحقيقي بدون تداخل مع التصفية العادية
    final bool isEffectTab = selectedCategoryIndex == 3;
    final bool isBundleTab = selectedCategoryIndex == 4; 
    
    final int count = isBundleTab 
        ? mockAristocracyBundles.length 
        : isEffectTab ? mockEntranceEffects.length : items.length;

    if (count == 0) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text('لا توجد منتجات في هذه الفئة حالياً', style: TextStyle(color: Colors.white30, fontFamily: 'Cairo', fontSize: 12)),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.85, 
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            // رص كروت التبويب الخامس (الباقات الاستقراطية الكاملة)
            if (isBundleTab) {
              final bundleItem = mockAristocracyBundles[index];
              return AristocracyBundleCard(
                bundle: bundleItem,
                onBuyTap: () {
                  _executePurchaseProcess(title: bundleItem.title, price: bundleItem.price);
                },
              );
            }
            // رص كروت التبويب الرابع (تأثيرات وبنرات الدخول الفردية)
            if (isEffectTab) {
              final effectItem = mockEntranceEffects[index];
              return EntranceEffectCard(
                effect: effectItem,
                onBuyTap: () {
                  _executePurchaseProcess(title: effectItem.title, price: effectItem.price);
                },
              );
            } 
            // رص كروت بقية الفئات العادية
            else {
              final storeItem = items[index];
              return StoreItemCard(
                item: storeItem,
                onBuyTap: () {
                  _executePurchaseProcess(title: storeItem.title, price: storeItem.price);
                },
              );
            }
          },
          childCount: count,
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
            Icon(icon, color: isSelected ? activeColor : Colors.white60, size: 14),
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
