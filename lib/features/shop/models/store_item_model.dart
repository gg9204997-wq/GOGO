import 'package:flutter/foundation.dart';

@immutable
class StoreItemModel {
  final String id;
  final String title;
  final String category;     // نوع المنتج: 'vip', 'frame', 'bubble'
  final String imageUrl;     // رابط صورة التاج أو الإطار من الـ Storage
  final int price;           // السعر بالجواهر
  final int requiredLevel;   // المستوى المطلوب للشراء إن وجد
  final bool isNew;

  const StoreItemModel({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.requiredLevel,
    required this.isNew,
  });

  factory StoreItemModel.fromMap(Map<String, dynamic> json) {
    return StoreItemModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      category: (json['category'] ?? 'frame').toString(),
      imageUrl: (json['image_url'] ?? '').toString(),
      price: (json['price'] as num?)?.toInt() ?? 0,
      requiredLevel: (json['required_level'] as num?)?.toInt() ?? 1,
      isNew: (json['is_new'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'image_url': imageUrl,
      'price': price,
      'required_level': requiredLevel,
      'is_new': isNew,
    };
  }
}
