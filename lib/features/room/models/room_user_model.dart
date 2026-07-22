import 'package:equatable/equatable.dart';

class RoomUserModel extends Equatable {
  final String id;
  final String roomId;
  final String userId;

  final String username;
  final String nickname;
  final String avatarUrl;

  final int level;

  final String role;

  final bool isOwner;
  final bool isModerator;
  final bool isMuted;
  final bool isBanned;

  final int seatNumber;

  final DateTime joinedAt;
  final DateTime updatedAt;

  const RoomUserModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.username,
    required this.nickname,
    required this.avatarUrl,
    required this.level,
    required this.role,
    required this.isOwner,
    required this.isModerator,
    required this.isMuted,
    required this.isBanned,
    required this.seatNumber,
    required this.joinedAt,
    required this.updatedAt,
  });

  factory RoomUserModel.empty() {
    return RoomUserModel(
      id: '',
      roomId: '',
      userId: '',
      username: '',
      nickname: '',
      avatarUrl: '',
      level: 1,
      role: 'user',
      isOwner: false,
      isModerator: false,
      isMuted: false,
      isBanned: false,
      seatNumber: -1,
      joinedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory RoomUserModel.fromMap(Map<String, dynamic> map) {
    return RoomUserModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',

      username: map['username']?.toString() ?? '',
      nickname: map['nickname']?.toString() ?? '',
      avatarUrl: map['avatar_url']?.toString() ?? '',

      level: (map['level'] as num?)?.toInt() ?? 1,

      role: map['role']?.toString() ?? 'user',

      isOwner: map['is_owner'] as bool? ?? false,
      isModerator: map['is_moderator'] as bool? ?? false,
      isMuted: map['is_muted'] as bool? ?? false,
      isBanned: map['is_banned'] as bool? ?? false,

      seatNumber: (map['seat_number'] as num?)?.toInt() ?? -1,

      joinedAt: DateTime.tryParse(
            map['joined_at']?.toString() ?? '',
          ) ??
          DateTime.now(),

      updatedAt: DateTime.tryParse(
            map['updated_at']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomId,
      'user_id': userId,
      'username': username,
      'nickname': nickname,
      'avatar_url': avatarUrl,
      'level': level,
      'role': role,
      'is_owner': isOwner,
      'is_moderator': isModerator,
      'is_muted': isMuted,
      'is_banned': isBanned,
      'seat_number': seatNumber,
      'joined_at': joinedAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory RoomUserModel.fromJson(Map<String, dynamic> json) {
    return RoomUserModel.fromMap(json);
  }

  Map<String, dynamic> toJson() => toMap();

  RoomUserModel copyWith({
    String? id,
    String? roomId,
    String? userId,
    String? username,
    String? nickname,
    String? avatarUrl,
    int? level,
    String? role,
    bool? isOwner,
    bool? isModerator,
    bool? isMuted,
    bool? isBanned,
    int? seatNumber,
    DateTime? joinedAt,
    DateTime? updatedAt,
  }) {
    return RoomUserModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      level: level ?? this.level,
      role: role ?? this.role,
      isOwner: isOwner ?? this.isOwner,
      isModerator: isModerator ?? this.isModerator,
      isMuted: isMuted ?? this.isMuted,
      isBanned: isBanned ?? this.isBanned,
      seatNumber: seatNumber ?? this.seatNumber,
      joinedAt: joinedAt ?? this.joinedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasSeat => seatNumber >= 0;

  bool get isAdmin => role == 'admin';

  bool get canManageRoom =>
      isOwner || isModerator || isAdmin;

  String get displayName {
    if (nickname.isNotEmpty) return nickname;
    if (username.isNotEmpty) return username;
    return 'User';
  }

  @override
  List<Object?> get props => [
        id,
        roomId,
        userId,
        username,
        nickname,
        avatarUrl,
        level,
        role,
        isOwner,
        isModerator,
        isMuted,
        isBanned,
        seatNumber,
        joinedAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'RoomUserModel(user: $displayName, role: $role)';
  }
}