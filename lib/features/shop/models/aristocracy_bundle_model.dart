import 'package:flutter/foundation.dart';

@immutable
class AristocracyBundleModel {
  final String id;
  final String title;
  final int price;              // السعر الإجمالي للحزمة بالجواهر
  final int vipLevelRequired;   // مستوى الـ VIP المطلوب للشراء
  final String frameName;       // اسم الإطار المتضمن
  final String effectName;      // اسم تأثير الدخول (السيارة) المتضمن
  final String bannerName;      // اسم بنر الترحيب المتضمن
  final String bubbleName;      // اسم فقاعة الشات المتضمنة

  const AristocracyBundleModel({
    required this.id,
    required this.title,
    required this.price,
    required this.vipLevelRequired,
    required this.frameName,
    required this.effectName,
    required this.bannerName,
    required this.bubbleName,
  });

  factory AristocracyBundleModel.fromMap(Map<String, dynamic> json) {
    return AristocracyBundleModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      price: (json['price'] as num?)?.toInt() ?? 0,
      vipLevelRequired: (json['vip_level_required'] as num?)?.toInt() ?? 0,
      frameName: (json['frame_name'] ?? '').toString(),
      effectName: (json['effect_name'] ?? '').toString(),
      bannerName: (json['banner_name'] ?? '').toString(),
      bubbleName: (json['bubble_name'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'vip_level_required': vipLevelRequired,
      'frame_name': frameName,
      'effect_name': effectName,
      'banner_name': bannerName,
      'bubble_name': bubbleName,
    };
  }
}
