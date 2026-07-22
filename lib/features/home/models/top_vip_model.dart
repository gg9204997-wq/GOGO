import 'package:flutter/foundation.dart';

@immutable
class TopVipModel {
  final String userId;
  final String name;
  final String avatar;
  final String frame;
  final int vipLevel;
  final DateTime? expiresAt;

  const TopVipModel({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.frame,
    required this.vipLevel,
    this.expiresAt,
  });

  factory TopVipModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return TopVipModel(
      userId:
          (json['user_id'] ?? '').toString(),

      name:
          (json['name'] ?? '').toString(),

      avatar:
          (json['avatar'] ?? '').toString(),

      frame:
          (json['frame'] ?? '').toString(),

      vipLevel:
          (json['vip_level'] as num?)
                  ?.toInt() ??
              1,

      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(
              json['expires_at'].toString(),
            ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'avatar': avatar,
      'frame': frame,
      'vip_level': vipLevel,
      'expires_at':
          expiresAt?.toIso8601String(),
    };
  }
}
