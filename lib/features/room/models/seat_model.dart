import 'package:equatable/equatable.dart';

class SeatModel extends Equatable {
  final String id;
  final String roomId;
  final int seatNumber;

  final bool micOn;
  final bool isMuted;
  final bool isLocked;
  final bool isSpeaking;
  final bool handRaised;
  final int micVolume;
  final bool isOwner;
  final bool isAdmin;
  final String seatType;
  final DateTime updatedAt;

  final String? userId;
  final DateTime? joinedAt;

  const SeatModel({
    required this.id,
    required this.roomId,
    required this.seatNumber,
    required this.micOn,
    required this.isMuted,
    required this.isLocked,
    required this.isSpeaking,
    required this.handRaised,
    required this.micVolume,
    required this.isOwner,
    required this.isAdmin,
    required this.seatType,
    required this.updatedAt,
    this.userId,
    this.joinedAt,
  });

  factory SeatModel.empty(int number) {
    return SeatModel(
      id: '',
      roomId: '',
      seatNumber: number,
      micOn: false,
      isMuted: false,
      isLocked: false,
      isSpeaking: false,
      handRaised: false,
      micVolume: 0,
      isOwner: false,
      isAdmin: false,
      seatType: 'normal',
      updatedAt: DateTime.now(),
      userId: null,
      joinedAt: null,
    );
  }

  factory SeatModel.fromMap(Map<String, dynamic> map) {
    return SeatModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      seatNumber: (map['seat_number'] as num?)?.toInt() ?? 0,

      micOn: map['mic_on'] as bool? ?? false,
      isMuted: map['is_muted'] as bool? ?? false,
      isLocked: map['is_locked'] as bool? ?? false,
      isSpeaking: map['is_speaking'] as bool? ?? false,
      handRaised: map['hand_raised'] as bool? ?? false,

      micVolume: (map['mic_volume'] as num?)?.toInt() ?? 0,

      isOwner: map['is_owner'] as bool? ?? false,
      isAdmin: map['is_admin'] as bool? ?? false,

      seatType: map['seat_type']?.toString() ?? 'normal',

      updatedAt:
          DateTime.tryParse(
                map['updated_at']?.toString() ?? '',
              ) ??
              DateTime.now(),

      userId: map['user_id']?.toString(),

      joinedAt: map['joined_at'] != null
          ? DateTime.tryParse(map['joined_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomId,
      'seat_number': seatNumber,
      'user_id': userId,
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
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel.fromMap(json);
  }

  Map<String, dynamic> toJson() => toMap();

  SeatModel copyWith({
    String? id,
    String? roomId,
    int? seatNumber,
    String? userId,
    bool? micOn,
    bool? isMuted,
    bool? isLocked,
    bool? isSpeaking,
    bool? handRaised,
    int? micVolume,
    bool? isOwner,
    bool? isAdmin,
    String? seatType,
    DateTime? joinedAt,
    DateTime? updatedAt,
  }) {
    return SeatModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      seatNumber: seatNumber ?? this.seatNumber,
      micOn: micOn ?? this.micOn,
      isMuted: isMuted ?? this.isMuted,
      isLocked: isLocked ?? this.isLocked,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      handRaised: handRaised ?? this.handRaised,
      micVolume: micVolume ?? this.micVolume,
      isOwner: isOwner ?? this.isOwner,
      isAdmin: isAdmin ?? this.isAdmin,
      seatType: seatType ?? this.seatType,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  bool get isEmpty => userId == null || userId!.isEmpty;

  bool get hasUser => !isEmpty;

  bool get canSpeak => hasUser && !isLocked;

  @override
  List<Object?> get props => [
        id,
        roomId,
        seatNumber,
        userId,
        micOn,
        isMuted,
        isLocked,
        isSpeaking,
        handRaised,
        micVolume,
        isOwner,
        isAdmin,
        seatType,
        joinedAt,
        updatedAt,
      ];
}