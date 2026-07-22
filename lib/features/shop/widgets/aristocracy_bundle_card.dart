import 'package:flutter/material.dart';
import 'package:joojo_chat/features/shop/models/aristocracy_bundle_model.dart';

class AristocracyBundleCard extends StatelessWidget {
  final AristocracyBundleModel bundle;
  final VoidCallback onBuyTap;

  const AristocracyBundleCard({
    required this.bundle,
    required this.onBuyTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color goldGlow = Color(0xffFFD700);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff150F26), // خلفية داكنة مائلة للأرجواني لتعطي هيبة الباقات
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: goldGlow.withValues(alpha: 0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: goldGlow.withValues(alpha: 0.08),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // شارة مستوى الـ VIP المطلوبة للباقت الملكية الكبرى
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [goldGlow, Colors.amber]),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'ملك ليفل ${bundle.vipLevelRequired}',
                  style: const TextStyle(color: Colors.black, fontSize: 7, fontWeight: FontWeight.w900, fontFamily: 'Cairo'),
                ),
              ),
              const Icon(Icons.workspace_premium_rounded, color: goldGlow, size: 12),
            ],
          ),

          // 🌟 منطقة رص محتويات الحزمة الأربعة بشكل مصغر وأنيق جداً كبريات المنصات العالمية بالملي
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSubComponentItem(Icons.portrait_rounded, bundle.frameName),
                  _buildSubComponentItem(Icons.directions_car_filled_rounded, bundle.effectName),
                  _buildSubComponentItem(Icons.campaign_rounded, bundle.bannerName),
                  _buildSubComponentItem(Icons.chat_bubble_rounded, bundle.bubbleName),
                ],
              ),
            ),
          ),

          // اسم الباقة الملكية الكبرى
          Text(
            bundle.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
          ),
          const SizedBox(height: 2),

          // السعر الفخم بالجواهر والماس وزر الاقتناء
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.diamond_rounded, color: Color(0xff00FFFF), size: 11),
                  const SizedBox(width: 2),
                  Text('${bundle.price}', style: const TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold)),
                ],
              ),
              GestureDetector(
                onTap: onBuyTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [goldGlow, Color(0xffFF8C00)]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('امتلاك الباقة', style: TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w900, fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubComponentItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xffA277FF), size: 10),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 7.5, fontFamily: 'Cairo', fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
