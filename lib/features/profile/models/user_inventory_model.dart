import 'package:flutter/foundation.dart';

@immutable
class UserInventoryModel {
  final String activeFrame;       // الإطار المفعّل حالياً حول الـ Avatar
  final String activeRide;        // السيارة المفعّلة لدخول الغرف
  final List<String> ownedItems;  // قائمة بكافة المعرفات للممتلكات المشحونة

  const UserInventoryModel({
    required this.activeFrame,
    required this.activeRide,
    required this.ownedItems,
  });

  factory UserInventoryModel.fromMap(Map<String, dynamic> json) {
    return UserInventoryModel(
      activeFrame: (json['active_frame'] ?? '').toString(),
      activeRide: (json['active_ride'] ?? '').toString(),
      ownedItems: (json['owned_items'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }
}
