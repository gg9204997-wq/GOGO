import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/shop/models/store_item_model.dart';

class StoreItemCard extends StatelessWidget {
  final StoreItemModel item;
  final VoidCallback onBuyTap;

  const StoreItemCard({
    required this.item,
    required this.onBuyTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color shopAccent = Color(0xffA277FF);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff120D1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: shopAccent.withValues(alpha: 0.15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // شارة المنتجات الجديدة الملكية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (item.isNew)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                  child: const Text('جديد', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                )
              else
                const SizedBox(),
              Text('Lv.${item.requiredLevel}', style: const TextStyle(color: Colors.white30, fontSize: 8, fontWeight: FontWeight.bold)),
            ],
          ),

          // صورة الإطار أو شارة الـ VIP القادمة ديناميكياً من السيرفر
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: item.imageUrl.isNotEmpty
                  ? CachedNetworkImage(imageUrl: item.imageUrl, fit: BoxFit.contain)
                  : Icon(item.category == 'vip' ? Icons.workspace_premium_rounded : Icons.star_border_purple500_rounded, color: const Color(0xffFFD700), size: 40),
            ),
          ),

          // عنوان المنتج المتغير بالملي
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
          ),
          const SizedBox(height: 4),

          // السعر بالجواهر وزر الشراء التفاعلي المضاء بالملي كالصورة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.diamond_rounded, color: Color(0xff00FFFF), size: 11),
                  const SizedBox(width: 2),
                  Text('${item.price}', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ],
              ),
              GestureDetector(
                onTap: onBuyTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xff9E70FF), Color(0xff6C38FF)]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('شراء', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
