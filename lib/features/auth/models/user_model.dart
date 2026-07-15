class UserModel {
  final String id;
  final String username;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String gender;
  final String country;
  final bool verified;
  final bool online;
  final bool banned;
  final int level;
  final int xp;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.gender,
    required this.country,
    required this.verified,
    required this.online,
    required this.banned,
    required this.level,
    required this.xp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      avatar: map['avatar'] as String,
      gender: map['gender'] as String,
      country: map['country'] as String,
      verified: map['verified'] as bool,
      online: map['online'] as bool,
      banned: map['banned'] as bool,
      level: map['level'] as int,
      xp: map['xp'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'gender': gender,
      'country': country,
      'verified': verified,
      'online': online,
      'banned': banned,
      'level': level,
      'xp': xp,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    String? gender,
    String? country,
    bool? verified,
    bool? online,
    bool? banned,
    int? level,
    int? xp,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      verified: verified ?? this.verified,
      online: online ?? this.online,
      banned: banned ?? this.banned,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}