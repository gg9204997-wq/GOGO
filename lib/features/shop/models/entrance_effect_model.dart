import 'package:flutter/foundation.dart';

@immutable
class EntranceEffectModel {
  final String id;
  final String title;
  final String effectUrl;     // رابط ملف التأثير (GIF أو ملف الحركة) من Supabase Storage
  final String category;      // نوع التأثير: 'car' (استقراطية سيارة)، 'banner' (بانر دخول)
  final int price;            // السعر بالجواهر
  final int vipLevelRequired; // مستوى الـ VIP المطلوب لامتلاكها
  final bool isAnimated;

  const EntranceEffectModel({
    required this.id,
    required this.title,
    required this.effectUrl,
    required this.category,
    required this.price,
    required this.vipLevelRequired,
    required this.isAnimated,
  });

  factory EntranceEffectModel.fromMap(Map<String, dynamic> json) {
    return EntranceEffectModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      effectUrl: (json['effect_url'] ?? '').toString(),
      category: (json['category'] ?? 'car').toString(),
      price: (json['price'] as num?)?.toInt() ?? 0,
      vipLevelRequired: (json['vip_level_required'] as num?)?.toInt() ?? 0,
      isAnimated: (json['is_animated'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'effect_url': effectUrl,
      'category': category,
      'price': price,
      'vip_level_required': vipLevelRequired,
      'is_animated': isAnimated,
    };
  }
}
