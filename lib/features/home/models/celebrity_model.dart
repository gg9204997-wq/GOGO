import 'package:flutter/foundation.dart';

@immutable
class CelebrityModel {
  final String id;
  final String name;
  final String avatar;
  final String frame;
  final String country;
  final int level;
  final int vipLevel;
  final bool verified;

  const CelebrityModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.frame,
    required this.country,
    required this.level,
    required this.vipLevel,
    required this.verified,
  });

  factory CelebrityModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return CelebrityModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      avatar: json['avatar']?.toString() ?? '',
      frame: json['frame']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      level: (json['level'] as num?)?.toInt() ?? 1,
      vipLevel: (json['vip_level'] as num?)?.toInt() ?? 0,
      verified: (json['verified'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'frame': frame,
      'country': country,
      'level': level,
      'vip_level': vipLevel,
      'verified': verified,
    };
  }

  CelebrityModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? frame,
    String? country,
    int? level,
    int? vipLevel,
    bool? verified,
  }) {
    return CelebrityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      frame: frame ?? this.frame,
      country: country ?? this.country,
      level: level ?? this.level,
      vipLevel: vipLevel ?? this.vipLevel,
      verified: verified ?? this.verified,
    );
  }
}