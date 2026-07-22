// Path: lib/features/auth/models/profile_model.dart

import 'package:flutter/foundation.dart';

@immutable
class UserProfileModel {
  final String id;
  final String userId;
  final String name;
  final String username;
  final String bio;
  final String gender;
  final String birthday;
  final String country;
  final String city;
  final String avatar;
  final String cover;
  final int level;
  final int xp;
  final int coins;
  final int diamonds;
  final int vipLevel;
  final int followers;
  final int following;
  final int visitors;
  final String familyId;
  final String agencyId;
  final bool online;
  final bool isHost;
  final bool isAdmin;
  final bool isBanned;
  final String language;
  final String status;
  final bool verified;
  final bool profileCompleted;
  final DateTime? lastLogin;
  final DateTime? lastSeen;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String roomId;
  final String frameId;
  final String badgeId;
  final String vehicleId;
  final String bubbleId;

  const UserProfileModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.username,
    required this.bio,
    required this.gender,
    required this.birthday,
    required this.country,
    required this.city,
    required this.avatar,
    required this.cover,
    required this.level,
    required this.xp,
    required this.coins,
    required this.diamonds,
    required this.vipLevel,
    required this.followers,
    required this.following,
    required this.visitors,
    required this.familyId,
    required this.agencyId,
    required this.online,
    required this.isHost,
    required this.isAdmin,
    required this.isBanned,
    required this.language,
    required this.status,
    required this.verified,
    required this.profileCompleted,
    // 🌟 تم ترتيب الحقول الإجبارية هنا أولاً بالملي لتصفية تحذير always_put_required_named_parameters_first
    required this.createdAt,
    required this.updatedAt,
    required this.roomId,
    required this.frameId,
    required this.badgeId,
    required this.vehicleId,
    required this.bubbleId,
    // 🌟 دفع الحقول الاختيارية (المحتمل أن تكون null) في نهاية المشيد تماماً لتطابق معايير Dart القياسية
    this.lastLogin,
    this.lastSeen,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: (map['id'] ?? '').toString(),
      userId: (map['user_id'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      username: (map['username'] ?? '').toString(),
      bio: (map['bio'] ?? '').toString(),
      gender: (map['gender'] ?? 'ذكر').toString(),
      birthday: (map['birthday'] ?? '').toString(),
      country: (map['country'] ?? '').toString(),
      city: (map['city'] ?? '').toString(),
      avatar: (map['avatar'] ?? '').toString(),
      cover: (map['cover'] ?? '').toString(),
      level: (map['level'] as num?)?.toInt() ?? 1,
      xp: (map['xp'] as num?)?.toInt() ?? 0,
      coins: (map['coins'] as num?)?.toInt() ?? 0,
      diamonds: (map['diamonds'] as num?)?.toInt() ?? 0,
      vipLevel: (map['vip_level'] as num?)?.toInt() ?? 0,
      followers: (map['followers'] as num?)?.toInt() ?? 0,
      following: (map['following'] as num?)?.toInt() ?? 0,
      visitors: (map['visitors'] as num?)?.toInt() ?? 0,
      familyId: (map['family_id'] ?? '').toString(),
      agencyId: (map['agency_id'] ?? '').toString(),
      online: (map['online'] as bool?) ?? false,
      isHost: (map['is_host'] as bool?) ?? false,
      isAdmin: (map['is_admin'] as bool?) ?? false,
      isBanned: (map['is_banned'] as bool?) ?? false,
      language: (map['language'] ?? 'ar').toString(),
      status: (map['status'] ?? '').toString(),
      verified: (map['verified'] as bool?) ?? false,
      profileCompleted: (map['profile_completed'] as bool?) ?? false,
      lastLogin: map['last_login'] != null ? DateTime.tryParse(map['last_login'].toString()) : null,
      lastSeen: map['last_seen'] != null ? DateTime.tryParse(map['last_seen'].toString()) : null,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'].toString()) : DateTime.now(),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at'].toString()) : DateTime.now(),
      roomId: (map['room_id'] ?? '').toString(),
      frameId: (map['frame_id'] ?? '').toString(),
      badgeId: (map['badge_id'] ?? '').toString(),
      vehicleId: (map['vehicle_id'] ?? '').toString(),
      bubbleId: (map['bubble_id'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'username': username,
      'bio': bio,
      'gender': gender,
      'birthday': birthday,
      'country': country,
      'city': city,
      'avatar': avatar,
      'cover': cover,
      'level': level,
      'xp': xp,
      'coins': coins,
      'diamonds': diamonds,
      'vip_level': vipLevel,
      'followers': followers,
      'following': following,
      'visitors': visitors,
      'family_id': familyId,
      'agency_id': agencyId,
      'online': online,
      'is_host': isHost,
      'is_admin': isAdmin,
      'is_banned': isBanned,
      'language': language,
      'status': status,
      'verified': verified,
      'profile_completed': profileCompleted,
      'last_login': lastLogin == null ? null : lastLogin!.toIso8601String(),
      'last_seen': lastSeen == null ? null : lastSeen!.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'room_id': roomId,
      'frame_id': frameId,
      'badge_id': badgeId,
      'vehicle_id': vehicleId,
      'bubble_id': bubbleId,
    };
  }
}
