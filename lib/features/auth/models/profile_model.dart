class ProfileModel {
  final String id;
  final String userId;
  final String name;
  final String username;
  final String bio;
  final String gender;
  final DateTime? birthday;
  final String country;
  final String city;
  final String avatar;
  final String cover;

  final int level;
  final int vipLevel;

  final int followers;
  final int following;
  final int visitors;

  final String? familyId;
  final String? agencyId;
  final String? roomId;

  final bool online;
  final bool isHost;
  final bool isAdmin;
  final bool isBanned;
  final bool verified;
  final bool profileCompleted;

  final int xp;
  final int diamonds;
  final int coins;

  final String? frameId;
  final String? badgeId;
  final String? vehicleId;
  final String? bubbleId;

  final String language;
  final String status;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLogin;
  final DateTime? lastSeen;

  const ProfileModel({
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
    required this.vipLevel,
    required this.followers,
    required this.following,
    required this.visitors,
    required this.familyId,
    required this.agencyId,
    required this.roomId,
    required this.online,
    required this.isHost,
    required this.isAdmin,
    required this.isBanned,
    required this.verified,
    required this.profileCompleted,
    required this.xp,
    required this.diamonds,
    required this.coins,
    required this.frameId,
    required this.badgeId,
    required this.vehicleId,
    required this.bubbleId,
    required this.language,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
    required this.lastSeen,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
  return ProfileModel(
    id: map['id']?.toString() ?? '',
    userId: map['user_id']?.toString() ?? '',
    name: map['name']?.toString() ?? '',
    username: map['username']?.toString() ?? '',
    bio: map['bio']?.toString() ?? '',
    gender: map['gender']?.toString() ?? '',
    birthday: map['birthday'] != null
        ? DateTime.tryParse(map['birthday'].toString())
        : null,
    country: map['country']?.toString() ?? '',
    city: map['city']?.toString() ?? '',
    avatar: map['avatar']?.toString() ?? '',
    cover: map['cover']?.toString() ?? '',

    level: (map['level'] as num?)?.toInt() ?? 0,
    vipLevel: (map['vip_level'] as num?)?.toInt() ?? 0,

    followers: (map['followers'] as num?)?.toInt() ?? 0,
    following: (map['following'] as num?)?.toInt() ?? 0,
    visitors: (map['visitors'] as num?)?.toInt() ?? 0,

    familyId: map['family_id']?.toString(),
    agencyId: map['agency_id']?.toString(),
    roomId: map['room_id']?.toString(),

    online: map['online'] as bool? ?? false,
    isHost: map['is_host'] as bool? ?? false,
    isAdmin: map['is_admin'] as bool? ?? false,
    isBanned: map['is_banned'] as bool? ?? false,
    verified: map['verified'] as bool? ?? false,
    profileCompleted: map['profile_completed'] as bool? ?? false,

    xp: (map['xp'] as num?)?.toInt() ?? 0,
    diamonds: (map['diamonds'] as num?)?.toInt() ?? 0,
    coins: (map['coins'] as num?)?.toInt() ?? 0,

    frameId: map['frame_id']?.toString(),
    badgeId: map['badge_id']?.toString(),
    vehicleId: map['vehicle_id']?.toString(),
    bubbleId: map['bubble_id']?.toString(),

    language: map['language']?.toString() ?? '',
    status: map['status']?.toString() ?? '',

    createdAt: DateTime.parse(map['created_at'].toString()),
    updatedAt: DateTime.parse(map['updated_at'].toString()),

    lastLogin: map['last_login'] != null
        ? DateTime.tryParse(map['last_login'].toString())
        : null,

    lastSeen: map['last_seen'] != null
        ? DateTime.tryParse(map['last_seen'].toString())
        : null,
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
      'birthday': birthday?.toIso8601String(),
      'country': country,
      'city': city,
      'avatar': avatar,
      'cover': cover,
      'level': level,
      'vip_level': vipLevel,
      'followers': followers,
      'following': following,
      'visitors': visitors,
      'family_id': familyId,
      'agency_id': agencyId,
      'room_id': roomId,
      'online': online,
      'is_host': isHost,
      'is_admin': isAdmin,
      'is_banned': isBanned,
      'verified': verified,
      'profile_completed': profileCompleted,
      'xp': xp,
      'diamonds': diamonds,
      'coins': coins,
      'frame_id': frameId,
      'badge_id': badgeId,
      'vehicle_id': vehicleId,
      'bubble_id': bubbleId,
      'language': language,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
      'last_seen': lastSeen?.toIso8601String(),
    };
  }
}