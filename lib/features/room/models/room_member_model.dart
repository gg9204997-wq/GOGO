import 'package:equatable/equatable.dart';

class RoomMemberModel extends Equatable {
  final String id;
  final String roomId;
  final String userId;
  final String role;
  final int? seatNumber;
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
    this.seatNumber,
    this.lastActive,
    this.leftAt,
  });

  factory RoomMemberModel.empty() => RoomMemberModel(
        id: '',
        roomId: '',
        userId: '',
        role: 'user',
        isMuted: false,
        isSpeaker: false,
        isOnline: false,
        isBlocked: false,
        micEnabled: false,
        cameraEnabled: false,
        diamondsSent: 0,
        coinsSent: 0,
        staySeconds: 0,
        joinedAt: DateTime.now(),
      );

  factory RoomMemberModel.fromMap(Map<String, dynamic> map) {
    return RoomMemberModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      role: map['role']?.toString() ?? 'user',
      seatNumber: (map['seat_number'] as num?)?.toInt(),
      isMuted: map['is_muted'] as bool? ?? false,
      isSpeaker: map['is_speaker'] as bool? ?? false,
      isOnline: map['is_online'] as bool? ?? false,
      isBlocked: map['is_blocked'] as bool? ?? false,
      micEnabled: map['mic_enabled'] as bool? ?? false,
      cameraEnabled: map['camera_enabled'] as bool? ?? false,
      diamondsSent: (map['diamonds_sent'] as num?)?.toInt() ?? 0,
      coinsSent: (map['coins_sent'] as num?)?.toInt() ?? 0,
      staySeconds: (map['stay_seconds'] as num?)?.toInt() ?? 0,
      joinedAt: DateTime.tryParse(map['joined_at']?.toString() ?? '') ??
          DateTime.now(),
      lastActive: map['last_active'] != null
          ? DateTime.tryParse(map['last_active'].toString())
          : null,
      leftAt: map['left_at'] != null
          ? DateTime.tryParse(map['left_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
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

  factory RoomMemberModel.fromJson(Map<String, dynamic> json) =>
      RoomMemberModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  RoomMemberModel copyWith({
    String? id,
    String? roomId,
    String? userId,
    String? role,
    int? seatNumber,
    bool? isMuted,
    bool? isSpeaker,
    bool? isOnline,
    bool? isBlocked,
    bool? micEnabled,
    bool? cameraEnabled,
    int? diamondsSent,
    int? coinsSent,
    int? staySeconds,
    DateTime? joinedAt,
    DateTime? lastActive,
    DateTime? leftAt,
  }) {
    return RoomMemberModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      seatNumber: seatNumber ?? this.seatNumber,
      isMuted: isMuted ?? this.isMuted,
      isSpeaker: isSpeaker ?? this.isSpeaker,
      isOnline: isOnline ?? this.isOnline,
      isBlocked: isBlocked ?? this.isBlocked,
      micEnabled: micEnabled ?? this.micEnabled,
      cameraEnabled: cameraEnabled ?? this.cameraEnabled,
      diamondsSent: diamondsSent ?? this.diamondsSent,
      coinsSent: coinsSent ?? this.coinsSent,
      staySeconds: staySeconds ?? this.staySeconds,
      joinedAt: joinedAt ?? this.joinedAt,
      lastActive: lastActive ?? this.lastActive,
      leftAt: leftAt ?? this.leftAt,
    );
  }

  bool get isOwner => role == 'owner';
  bool get isModerator => role == 'moderator';
  bool get hasSeat => seatNumber != null;

  @override
  List<Object?> get props => [
        id,
        roomId,
        userId,
        role,
        seatNumber,
        isMuted,
        isSpeaker,
        isOnline,
        isBlocked,
        micEnabled,
        cameraEnabled,
        diamondsSent,
        coinsSent,
        staySeconds,
        joinedAt,
        lastActive,
        leftAt,
      ];
}