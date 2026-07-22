import 'package:flutter/foundation.dart';

@immutable
class TopRichModel {
  final String id;
  final String name;
  final String avatar;
  final String frame;
  final int level;
  final int vipLevel;
  final int diamonds;

  const TopRichModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.frame,
    required this.level,
    required this.vipLevel,
    required this.diamonds,
  });

  factory TopRichModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return TopRichModel(
      id: (json['id'] ?? '').toString(),

      name: (json['name'] ?? '').toString(),

      avatar: (json['avatar'] ?? '').toString(),

      frame: (json['frame'] ?? '').toString(),

      level:
          (json['level'] as num?)?.toInt() ?? 1,

      vipLevel:
          (json['vip_level'] as num?)?.toInt() ?? 0,

      diamonds:
          (json['diamonds'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'frame': frame,
      'level': level,
      'vip_level': vipLevel,
      'diamonds': diamonds,
    };
  }
}
