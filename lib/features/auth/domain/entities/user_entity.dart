import 'package:flutter/foundation.dart';

@immutable
class UserEntity {
  final String id;
  final String username;
  final String? nickname;
  final String? avatarUrl;
  final int diamondsBalance;
  final int coinsBalance;
  final int currentLevel;
  final String role;
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

  const UserEntity({
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

  String get fullName => name ?? username;
  String get email => '';
}
