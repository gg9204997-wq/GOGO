import 'package:flutter/foundation.dart';

@immutable
class RoomMemberModel {
  final String id;
  final String roomId;
  final String userId;
  final String role;
  final int seatNumber;
  final bool isMuted;
  final bool isSpeaker;
  final bool isOnline;
  final bool isBlocked;
  final bool micEnabled;
  final bool cameraEnabled;
  final int diamondsSent;
  final int coinsSent;
  final int staySeconds;
  final DateTime joinedAt;
  final DateTime? lastActive;
  final DateTime? leftAt;

  const RoomMemberModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.role,
    required this.seatNumber,
    required this.isMuted,
    required this.isSpeaker,
    required this.isOnline,
    required this.isBlocked,
    required this.micEnabled,
    required this.cameraEnabled,
    required this.diamondsSent,
    required this.coinsSent,
    required this.staySeconds,
    required this.joinedAt,
    this.lastActive,
    this.leftAt,
  });

  factory RoomMemberModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return RoomMemberModel(
      id: (json['id'] ?? '').toString(),

      roomId: (json['room_id'] ?? '').toString(),

      userId: (json['user_id'] ?? '').toString(),

      role: (json['role'] ?? 'member').toString(),

      seatNumber: (json['seat_number'] as num?)?.toInt() ?? -1,

      isMuted: json['is_muted'] as bool? ?? false,

      isSpeaker: json['is_speaker'] as bool? ?? false,

      isOnline: json['is_online'] as bool? ?? true,

      isBlocked: json['is_blocked'] as bool? ?? false,

      micEnabled: json['mic_enabled'] as bool? ?? true,

      cameraEnabled: json['camera_enabled'] as bool? ?? false,

      diamondsSent:
          (json['diamonds_sent'] as num?)?.toInt() ?? 0,

      coinsSent:
          (json['coins_sent'] as num?)?.toInt() ?? 0,

      staySeconds:
          (json['stay_seconds'] as num?)?.toInt() ?? 0,

      joinedAt: json['joined_at'] != null
          ? DateTime.parse(json['joined_at'].toString())
          : DateTime.now(),

      lastActive: json['last_active'] != null
          ? DateTime.parse(json['last_active'].toString())
          : null,

      leftAt: json['left_at'] != null
          ? DateTime.parse(json['left_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomId,
      'user_id': userId,
      'role': role,
      'seat_number': seatNumber,
      'is_muted': isMuted,
      'is_speaker': isSpeaker,
      'is_online': isOnline,
      'is_blocked': isBlocked,
      'mic_enabled': micEnabled,
      'camera_enabled': cameraEnabled,
      'diamonds_sent': diamondsSent,
      'coins_sent': coinsSent,
      'stay_seconds': staySeconds,
      'joined_at': joinedAt.toIso8601String(),
      'last_active': lastActive?.toIso8601String(),
      'left_at': leftAt?.toIso8601String(),
    };
  }

  bool get isHost => role == 'owner';

  bool get isModerator => role == 'moderator';

  bool get isMember => role == 'member';
}