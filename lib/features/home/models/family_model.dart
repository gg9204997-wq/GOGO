import 'package:flutter/foundation.dart';

@immutable
class FamilyModel {
  final String id;
  final String ownerId;
  final String familyName;
  final String familyLogo;
  final String familyCover;
  final String bio;
  final int level;
  final int points;
  final int members;
  final DateTime createdAt;

  const FamilyModel({
    required this.id,
    required this.ownerId,
    required this.familyName,
    required this.familyLogo,
    required this.familyCover,
    required this.bio,
    required this.level,
    required this.points,
    required this.members,
    required this.createdAt,
  });

  factory FamilyModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return FamilyModel(
      id: json['id']?.toString() ?? '',
      ownerId: json['owner_id']?.toString() ?? '',
      familyName: json['family_name']?.toString() ?? '',
      familyLogo: json['family_logo']?.toString() ?? '',
      familyCover: json['family_cover']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      level: (json['level'] as num?)?.toInt() ?? 1,
      points: (json['points'] as num?)?.toInt() ?? 0,
      members: (json['members'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner_id': ownerId,
      'family_name': familyName,
      'family_logo': familyLogo,
      'family_cover': familyCover,
      'bio': bio,
      'level': level,
      'points': points,
      'members': members,
      'created_at': createdAt.toIso8601String(),
    };
  }

  FamilyModel copyWith({
    String? id,
    String? ownerId,
    String? familyName,
    String? familyLogo,
    String? familyCover,
    String? bio,
    int? level,
    int? points,
    int? members,
    DateTime? createdAt,
  }) {
    return FamilyModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      familyName: familyName ?? this.familyName,
      familyLogo: familyLogo ?? this.familyLogo,
      familyCover: familyCover ?? this.familyCover,
      bio: bio ?? this.bio,
      level: level ?? this.level,
      points: points ?? this.points,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}