import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String id;

  // Users Table
  final String username;
  final String? nickname;
  final String? avatarUrl;
  final int diamondsBalance;
  final int coinsBalance;
  final int currentLevel;
  final String role;

  // Profiles Table
  final String? name;
  final String? bio;
  final String? gender;
  final DateTime? birthday;
  final String? country;
  final String? city;
  final String? cover;

  final int level;
  final int vipLevel;

  final int followers;
  final int following;
  final int visitors;

  final int xp;
  final int diamonds;
  final int coins;

  final String? familyId;
  final String? agencyId;
  final String? frameId;
  final String? badgeId;
  final String? vehicleId;
  final String? bubbleId;
  final String? roomId;

  final bool online;
  final bool isHost;
  final bool isAdmin;
  final bool isBanned;
  final bool verified;
  final bool profileCompleted;

  final String language;
  final String status;

  final DateTime? lastLogin;
  final DateTime? lastSeen;

  final DateTime createdAt;
  final DateTime? updatedAt;

  // Convenience getters
  String get fullName => name ?? username;
  String get email => '';

  const UserModel({
    required this.id,
    required this.username,
    required this.createdAt,

    this.nickname,
    this.avatarUrl,
    this.diamondsBalance = 0,
    this.coinsBalance = 0,
    this.currentLevel = 1,
    this.role = 'user',

    this.name,
    this.bio,
    this.gender,
    this.birthday,
    this.country,
    this.city,
    this.cover,

    this.level = 1,
    this.vipLevel = 0,

    this.followers = 0,
    this.following = 0,
    this.visitors = 0,

    this.xp = 0,
    this.diamonds = 0,
    this.coins = 0,

    this.familyId,
    this.agencyId,
    this.frameId,
    this.badgeId,
    this.vehicleId,
    this.bubbleId,
    this.roomId,

    this.online = false,
    this.isHost = false,
    this.isAdmin = false,
    this.isBanned = false,
    this.verified = false,
    this.profileCompleted = false,

    this.language = 'ar',
    this.status = 'offline',

    this.lastLogin,
    this.lastSeen,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      return DateTime.tryParse(value.toString());
    }

    return UserModel(
      id: json['id'] as String,

      username: json['username'] as String? ?? '',
      nickname: json['nickname'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      diamondsBalance: json['diamonds_balance'] as int? ?? 0,
      coinsBalance: json['coins_balance'] as int? ?? 0,
      currentLevel: json['current_level'] as int? ?? 1,
      role: json['role'] as String? ?? 'user',

      name: json['name'] as String?,
      bio: json['bio'] as String?,
      gender: json['gender'] as String?,
      birthday: parseDate(json['birthday']),
      country: json['country'] as String?,
      city: json['city'] as String?,
      cover: json['cover'] as String?,

      level: json['level'] as int? ?? 1,
      vipLevel: json['vip_level'] as int? ?? 0,

      followers: json['followers'] as int? ?? 0,
      following: json['following'] as int? ?? 0,
      visitors: json['visitors'] as int? ?? 0,

      xp: (json['xp'] as num?)?.toInt() ?? 0,
      diamonds: (json['diamonds'] as num?)?.toInt() ?? 0,
      coins: (json['coins'] as num?)?.toInt() ?? 0,

      familyId: json['family_id']?.toString(),
      agencyId: json['agency_id']?.toString(),
      frameId: json['frame_id']?.toString(),
      badgeId: json['badge_id']?.toString(),
      vehicleId: json['vehicle_id']?.toString(),
      bubbleId: json['bubble_id']?.toString(),
      roomId: json['room_id']?.toString(),

      online: json['online'] as bool? ?? false,
      isHost: json['is_host'] as bool? ?? false,
      isAdmin: json['is_admin'] as bool? ?? false,
      isBanned: json['is_banned'] as bool? ?? false,
      verified: json['verified'] as bool? ?? false,
      profileCompleted: json['profile_completed'] as bool? ?? false,

      language: json['language'] as String? ?? 'ar',
      status: json['status'] as String? ?? 'offline',

      lastLogin: parseDate(json['last_login']),
      lastSeen: parseDate(json['last_seen']),

      createdAt: parseDate(json['created_at']) ?? DateTime.now(),
      updatedAt: parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'nickname': nickname,
      'avatar_url': avatarUrl,
      'diamonds_balance': diamondsBalance,
      'coins_balance': coinsBalance,
      'current_level': currentLevel,
      'role': role,
      'name': name,
      'bio': bio,
      'gender': gender,
      'birthday': birthday?.toIso8601String(),
      'country': country,
      'city': city,
      'cover': cover,
      'level': level,
      'vip_level': vipLevel,
      'followers': followers,
      'following': following,
      'visitors': visitors,
      'xp': xp,
      'diamonds': diamonds,
      'coins': coins,
      'family_id': familyId,
      'agency_id': agencyId,
      'frame_id': frameId,
      'badge_id': badgeId,
      'vehicle_id': vehicleId,
      'bubble_id': bubbleId,
      'room_id': roomId,
      'online': online,
      'is_host': isHost,
      'is_admin': isAdmin,
      'is_banned': isBanned,
      'verified': verified,
      'profile_completed': profileCompleted,
      'language': language,
      'status': status,
      'last_login': lastLogin?.toIso8601String(),
      'last_seen': lastSeen?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? nickname,
    String? avatarUrl,
    int? diamondsBalance,
    int? coinsBalance,
    int? currentLevel,
    String? role,
    String? name,
    String? bio,
    String? gender,
    DateTime? birthday,
    String? country,
    String? city,
    String? cover,
    int? level,
    int? vipLevel,
    int? followers,
    int? following,
    int? visitors,
    int? xp,
    int? diamonds,
    int? coins,
    String? familyId,
    String? agencyId,
    String? frameId,
    String? badgeId,
    String? vehicleId,
    String? bubbleId,
    String? roomId,
    bool? online,
    bool? isHost,
    bool? isAdmin,
    bool? isBanned,
    bool? verified,
    bool? profileCompleted,
    String? language,
    String? status,
    DateTime? lastLogin,
    DateTime? lastSeen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      diamondsBalance: diamondsBalance ?? this.diamondsBalance,
      coinsBalance: coinsBalance ?? this.coinsBalance,
      currentLevel: currentLevel ?? this.currentLevel,
      role: role ?? this.role,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      country: country ?? this.country,
      city: city ?? this.city,
      cover: cover ?? this.cover,
      level: level ?? this.level,
      vipLevel: vipLevel ?? this.vipLevel,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      visitors: visitors ?? this.visitors,
      xp: xp ?? this.xp,
      diamonds: diamonds ?? this.diamonds,
      coins: coins ?? this.coins,
      familyId: familyId ?? this.familyId,
      agencyId: agencyId ?? this.agencyId,
      frameId: frameId ?? this.frameId,
      badgeId: badgeId ?? this.badgeId,
      vehicleId: vehicleId ?? this.vehicleId,
      bubbleId: bubbleId ?? this.bubbleId,
      roomId: roomId ?? this.roomId,
      online: online ?? this.online,
      isHost: isHost ?? this.isHost,
      isAdmin: isAdmin ?? this.isAdmin,
      isBanned: isBanned ?? this.isBanned,
      verified: verified ?? this.verified,
      profileCompleted: profileCompleted ?? this.profileCompleted,
      language: language ?? this.language,
      status: status ?? this.status,
      lastLogin: lastLogin ?? this.lastLogin,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
