import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/shop/models/entrance_effect_model.dart';

class EntranceEffectCard extends StatelessWidget {
  final EntranceEffectModel effect;
  final VoidCallback onBuyTap;

  const EntranceEffectCard({
    required this.effect,
    required this.onBuyTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد لون الوهج النيوني الفريد بحسب نوع وفخامة الاستقراطية (ذهبي للتنين، برتقالي مشع للامبورغيني، بنفسجي للبرق)
    final Color neonColor = effect.title.contains('تنين')
        ? const Color(0xffFFD700)
        : effect.title.contains('لامبورغيني')
            ? const Color(0xffFF4500)
            : const Color(0xffA277FF);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff120D1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: neonColor.withValues(alpha: 0.25), width: 1),
        boxShadow: [
          // إضاءة نيون خفيفة تحيط بالكرت بالكامل لتعطيه طابع الاستقراطيات الملكية الفخم
          BoxShadow(
            color: neonColor.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // الشارة العلوية الملكية لمستوى الـ VIP المطلوب لامتلاك الاستقراطية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [neonColor, neonColor.withValues(alpha: 0.7)]),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'VIP ${effect.vipLevelRequired}',
                  style: TextStyle(
                    color: neonColor == const Color(0xffFFD700) ? Colors.black : Colors.white,
                    fontSize: 7,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              Icon(Icons.workspace_premium_rounded, color: neonColor, size: 12),
            ],
          ),

          // 🌟 ميكانيزم مجسمات النيون: لو الرابط فاضي، بنولد هالة ضوئية دائرية نابضة وجواها أيقونة الاستقراطية ثلاثية الأبعاد
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: effect.effectUrl.isNotEmpty
                  ? CachedNetworkImage(imageUrl: effect.effectUrl, fit: BoxFit.contain)
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        // وهج نيون دائري خلف مجسم الاستقراطية
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: neonColor.withValues(alpha: 0.2),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        // أيقونة مجسم الاستقراطية المتغيرة (تنين، سيارة سباق، أو شارات صاعقة برق) بالملي
                        Icon(
                          effect.title.contains('تنين')
                              ? Icons.brightness_auto_rounded
                              : effect.title.contains('لامبورغيني')
                                  ? Icons.directions_car_filled_rounded
                                  : Icons.bolt_rounded,
                          color: neonColor,
                          size: 36,
                        ),
                      ],
                    ),
            ),
          ),

          // اسم وتصنيف الاستقراطية الملكية
          Text(
            effect.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
          ),
          const SizedBox(height: 4),

          // منطقة اقتطاع الجواهر الفوري للتمكين
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.diamond_rounded, color: Color(0xff00FFFF), size: 11),
                  const SizedBox(width: 2),
                  Text('${effect.price}', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [neonColor, neonColor.withValues(alpha: 0.7)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'امتلاك',
                  style: TextStyle(
                    color: neonColor == const Color(0xffFFD700) ? Colors.black : Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
