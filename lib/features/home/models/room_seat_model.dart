import 'package:flutter/foundation.dart';

@immutable
class RoomSeatModel {
  final String id;
  final String roomId;

  final int seatNumber;

  final String? userId;

  final String username;
  final String avatar;

  final int level;
  final int vipLevel;

  final String frame;
  final String chatBubble;

  final bool micOn;
  final bool isMuted;
  final bool isLocked;
  final bool isSpeaking;
  final bool handRaised;

  final double micVolume;

  final bool isOwner;
  final bool isAdmin;

  final String seatType;

  final DateTime? joinedAt;
  final DateTime? updatedAt;

  const RoomSeatModel({
    // أولاً: جميع المعاملات المطلوبة (required) متوافقة مع قاعدة always_put_required_named_parameters_first
    required this.id,
    required this.roomId,
    required this.seatNumber,
    required this.username,
    required this.avatar,
    required this.level,
    required this.vipLevel,
    required this.frame,
    required this.chatBubble,
    required this.micOn,
    required this.isMuted,
    required this.isLocked,
    required this.isSpeaking,
    required this.handRaised,
    required this.micVolume,
    required this.isOwner,
    required this.isAdmin,
    required this.seatType,
    
    // ثانياً: المعاملات الاختيارية (Nullables) في نهاية الـ Constructor
    this.userId,
    this.joinedAt,
    this.updatedAt,
  });

  factory RoomSeatModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return RoomSeatModel(
      id: (json['id'] ?? '').toString(),

      roomId: (json['room_id'] ?? '').toString(),

      seatNumber:
          (json['seat_number'] as num?)?.toInt() ?? 0,

      userId: json['user_id']?.toString(),

      username:
          (json['username'] ?? '').toString(),

      avatar:
          (json['avatar'] ?? '').toString(),

      level:
          (json['level'] as num?)?.toInt() ?? 1,

      vipLevel:
          (json['vip_level'] as num?)?.toInt() ?? 0,

      frame:
          (json['frame'] ?? '').toString(),

      chatBubble:
          (json['chat_bubble'] ?? '').toString(),

      micOn:
          (json['mic_on'] as bool?) ?? false,

      isMuted:
          (json['is_muted'] as bool?) ?? false,

      isLocked:
          (json['is_locked'] as bool?) ?? false,

      isSpeaking:
          (json['is_speaking'] as bool?) ?? false,

      handRaised:
          (json['hand_raised'] as bool?) ?? false,

      micVolume:
          (json['mic_volume'] as num?)?.toDouble() ??
              0.0,

      isOwner:
          (json['is_owner'] as bool?) ?? false,

      isAdmin:
          (json['is_admin'] as bool?) ?? false,

      seatType:
          (json['seat_type'] ?? 'normal').toString(),

      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(
              json['joined_at'].toString(),
            ),

      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(
              json['updated_at'].toString(),
            ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomId,
      'seat_number': seatNumber,
      'user_id': userId,
      'username': username,
      'avatar': avatar,
      'level': level,
      'vip_level': vipLevel,
      'frame': frame,
      'chat_bubble': chatBubble,
      'mic_on': micOn,
      'is_muted': isMuted,
      'is_locked': isLocked,
      'is_speaking': isSpeaking,
      'hand_raised': handRaised,
      'mic_volume': micVolume,
      'is_owner': isOwner,
      'is_admin': isAdmin,
      'seat_type': seatType,
      'joined_at': joinedAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get isEmpty => userId == null || userId!.isEmpty;

  bool get occupied => !isEmpty;
}
