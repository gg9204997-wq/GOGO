import 'package:flutter/foundation.dart';

@immutable
class BannerModel {
  final String id;
  final String title;
  final String image;
  final bool isActive;
  final int sortOrder;

  final String? targetType;
  final String? targetId;

  const BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.isActive,
    required this.sortOrder,
    this.targetType,
    this.targetId,
  });

  factory BannerModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return BannerModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      image: json['image']?.toString() ?? '',

      isActive: (json['is_active'] as bool?) ?? true,

      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,

      targetType: json['target_type']?.toString(),
      targetId: json['target_id']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'is_active': isActive,
      'sort_order': sortOrder,
      'target_type': targetType,
      'target_id': targetId,
    };
  }

  BannerModel copyWith({
    String? id,
    String? title,
    String? image,
    bool? isActive,
    int? sortOrder,
    String? targetType,
    String? targetId,
  }) {
    return BannerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
    );
  }
}