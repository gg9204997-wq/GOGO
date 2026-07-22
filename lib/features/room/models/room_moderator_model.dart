import 'package:equatable/equatable.dart';

class RoomModeratorModel extends Equatable {
  final String id;
  final String roomId;
  final String userId;
  final String role;
  final String? grantedBy;
  final Map<String, dynamic> permissions;
  final bool active;
  final DateTime? expiresAt;
  final String? revokedBy;
  final DateTime? revokedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomModeratorModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.role,
    required this.permissions,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.grantedBy,
    this.expiresAt,
    this.revokedBy,
    this.revokedAt,
  });

  factory RoomModeratorModel.empty() => RoomModeratorModel(
        id: '',
        roomId: '',
        userId: '',
        role: 'moderator',
        permissions: const {},
        active: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory RoomModeratorModel.fromMap(Map<String, dynamic> map) {
    return RoomModeratorModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      role: map['role']?.toString() ?? 'moderator',
      grantedBy: map['granted_by']?.toString(),
      permissions: map['permissions'] is Map
          ? Map<String, dynamic>.from(map['permissions'] as Map)
          : const {},
      active: map['active'] as bool? ?? true,
      expiresAt: map['expires_at'] != null
          ? DateTime.tryParse(map['expires_at'].toString())
          : null,
      revokedBy: map['revoked_by']?.toString(),
      revokedAt: map['revoked_at'] != null
          ? DateTime.tryParse(map['revoked_at'].toString())
          : null,
      createdAt: DateTime.tryParse(
            map['created_at']?.toString() ?? '',
          ) ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(
            map['updated_at']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'room_id': roomId,
        'user_id': userId,
        'role': role,
        'granted_by': grantedBy,
        'permissions': permissions,
        'active': active,
        'expires_at': expiresAt?.toIso8601String(),
        'revoked_by': revokedBy,
        'revoked_at': revokedAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory RoomModeratorModel.fromJson(Map<String, dynamic> json) =>
      RoomModeratorModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  RoomModeratorModel copyWith({
    String? id,
    String? roomId,
    String? userId,
    String? role,
    String? grantedBy,
    Map<String, dynamic>? permissions,
    bool? active,
    DateTime? expiresAt,
    String? revokedBy,
    DateTime? revokedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomModeratorModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      grantedBy: grantedBy ?? this.grantedBy,
      permissions: permissions ?? this.permissions,
      active: active ?? this.active,
      expiresAt: expiresAt ?? this.expiresAt,
      revokedBy: revokedBy ?? this.revokedBy,
      revokedAt: revokedAt ?? this.revokedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isActive => active;

  bool get isPermanent => expiresAt == null;

  @override
  List<Object?> get props => [
        id,
        roomId,
        userId,
        role,
        grantedBy,
        permissions,
        active,
        expiresAt,
        revokedBy,
        revokedAt,
        createdAt,
        updatedAt,
      ];
}