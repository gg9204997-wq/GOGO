import 'package:equatable/equatable.dart';

class RoomMessageModel extends Equatable {
  final String id;
  final String roomId;
  final String sender;
  final String message;
  final String type;
  final String? replyTo;
  final String? image;
  final String? giftId;
  final int giftCount;
  final int voiceDuration;
  final bool isDeleted;
  final bool isSystem;
  final bool edited;
  final bool translated;
  final String? language;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomMessageModel({
    required this.id,
    required this.roomId,
    required this.sender,
    required this.message,
    required this.type,
    required this.giftCount,
    required this.voiceDuration,
    required this.isDeleted,
    required this.isSystem,
    required this.edited,
    required this.translated,
    required this.createdAt,
    required this.updatedAt,
    this.replyTo,
    this.image,
    this.giftId,
    this.language,
  });

  factory RoomMessageModel.empty() => RoomMessageModel(
        id: '',
        roomId: '',
        sender: '',
        message: '',
        type: 'text',
        giftCount: 0,
        voiceDuration: 0,
        isDeleted: false,
        isSystem: false,
        edited: false,
        translated: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory RoomMessageModel.fromMap(Map<String, dynamic> map) {
    return RoomMessageModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      sender: map['sender']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
      type: map['type']?.toString() ?? 'text',
      replyTo: map['reply_to']?.toString(),
      image: map['image']?.toString(),
      giftId: map['gift_id']?.toString(),
      giftCount: (map['gift_count'] as num?)?.toInt() ?? 0,
      voiceDuration: (map['voice_duration'] as num?)?.toInt() ?? 0,
      isDeleted: map['is_deleted'] as bool? ?? false,
      isSystem: map['is_system'] as bool? ?? false,
      edited: map['edited'] as bool? ?? false,
      translated: map['translated'] as bool? ?? false,
      language: map['language']?.toString(),
      createdAt: DateTime.tryParse(map['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'room_id': roomId,
        'sender': sender,
        'message': message,
        'type': type,
        'reply_to': replyTo,
        'image': image,
        'gift_id': giftId,
        'gift_count': giftCount,
        'voice_duration': voiceDuration,
        'is_deleted': isDeleted,
        'is_system': isSystem,
        'edited': edited,
        'translated': translated,
        'language': language,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory RoomMessageModel.fromJson(Map<String, dynamic> json) => RoomMessageModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  RoomMessageModel copyWith({
    String? id,
    String? roomId,
    String? sender,
    String? message,
    String? type,
    String? replyTo,
    String? image,
    String? giftId,
    int? giftCount,
    int? voiceDuration,
    bool? isDeleted,
    bool? isSystem,
    bool? edited,
    bool? translated,
    String? language,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomMessageModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      sender: sender ?? this.sender,
      message: message ?? this.message,
      type: type ?? this.type,
      replyTo: replyTo ?? this.replyTo,
      image: image ?? this.image,
      giftId: giftId ?? this.giftId,
      giftCount: giftCount ?? this.giftCount,
      voiceDuration: voiceDuration ?? this.voiceDuration,
      isDeleted: isDeleted ?? this.isDeleted,
      isSystem: isSystem ?? this.isSystem,
      edited: edited ?? this.edited,
      translated: translated ?? this.translated,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isText => type == 'text';
  bool get isGift => type == 'gift';
  bool get isVoice => type == 'voice';
  bool get hasReply => replyTo != null && replyTo!.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        roomId,
        sender,
        message,
        type,
        replyTo,
        image,
        giftId,
        giftCount,
        voiceDuration,
        isDeleted,
        isSystem,
        edited,
        translated,
        language,
        createdAt,
        updatedAt,
      ];
}
