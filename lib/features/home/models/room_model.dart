import 'package:flutter/foundation.dart';

@immutable
class RoomModel {
  final String id;
  final String ownerId;

  final String roomName;
  final String roomCover;
  final String roomBackground;

  final String? description;
  final String category;
  final String language;
  final String country;

  final String? password;
  final String roomType;

  final int seatCount;
  final int activeUsers;

  final int roomLevel;
  final int heat;
  final int totalVisitors;
  final int totalGifts;

  final String? announcement;

  final List<String> tags;

  final bool allowGuests;
  final bool allowChat;
  final bool allowGifts;
  final bool allowMic;

  final bool isLocked;
  final bool isOfficial;
  final bool isRecommended;
  final bool verified;

  final String ownerName;
  final String ownerAvatar;

  final String roomNumber;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? closedAt;

  const RoomModel({
    required this.id,
    required this.ownerId,
    required this.roomName,
    required this.roomCover,
    required this.roomBackground,
    required this.category,
    required this.language,
    required this.country,
    required this.roomType,
    required this.seatCount,
    required this.activeUsers,
    required this.roomLevel,
    required this.heat,
    required this.totalVisitors,
    required this.totalGifts,
    required this.tags,
    required this.allowGuests,
    required this.allowChat,
    required this.allowGifts,
    required this.allowMic,
    required this.isLocked,
    required this.isOfficial,
    required this.isRecommended,
    required this.verified,
    required this.ownerName,
    required this.ownerAvatar,
    required this.roomNumber,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.password,
    this.announcement,
    this.closedAt,
  });

  factory RoomModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return RoomModel(
      id: (json['id'] ?? '').toString(),

      ownerId: (json['owner_id'] ?? '').toString(),

      roomName: (json['room_name'] ?? '').toString(),

      roomCover: (json['room_cover'] ?? '').toString(),

      roomBackground:
          (json['room_background'] ?? '').toString(),

      description: json['description']?.toString(),

      category: (json['category'] ?? '').toString(),

      language:
          (json['language'] ?? 'ar').toString(),

      country: (json['country'] ?? '').toString(),

      password: json['password']?.toString(),

      roomType:
          (json['room_type'] ?? 'public')
              .toString(),

      seatCount:
          (json['seat_count'] as num?)?.toInt() ??
              8,

      activeUsers:
          (json['active_users'] as num?)
                  ?.toInt() ??
              0,

      roomLevel:
          (json['room_level'] as num?)
                  ?.toInt() ??
              1,

      heat:
          (json['heat'] as num?)?.toInt() ?? 0,

      totalVisitors:
          (json['total_visitors'] as num?)
                  ?.toInt() ??
              0,

      totalGifts:
          (json['total_gifts'] as num?)
                  ?.toInt() ??
              0,

      announcement:
          json['announcement']?.toString(),

      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],

      allowGuests:
          (json['allow_guests'] as bool?) ??
              true,

      allowChat:
          (json['allow_chat'] as bool?) ?? true,

      allowGifts:
          (json['allow_gifts'] as bool?) ??
              true,

      allowMic:
          (json['allow_mic'] as bool?) ?? true,

      isLocked:
          (json['is_locked'] as bool?) ?? false,

      isOfficial:
          (json['is_official'] as bool?) ??
              false,

      isRecommended:
          (json['is_recommended'] as bool?) ??
              false,

      verified:
          (json['verified'] as bool?) ?? false,

      ownerName:
          (json['owner_name'] ?? '').toString(),

      ownerAvatar:
          (json['owner_avatar'] ?? '')
              .toString(),

      roomNumber:
          (json['room_number'] ?? '').toString(),

      createdAt: json['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(
              json['created_at'].toString(),
            ),

      updatedAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(
              json['updated_at'].toString(),
            ),

      closedAt: json['closed_at'] == null
          ? null
          : DateTime.parse(
              json['closed_at'].toString(),
            ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner_id': ownerId,
      'room_name': roomName,
      'room_cover': roomCover,
      'room_background': roomBackground,
      'description': description,
      'category': category,
      'language': language,
      'country': country,
      'password': password,
      'room_type': roomType,
      'seat_count': seatCount,
      'active_users': activeUsers,
      'room_level': roomLevel,
      'heat': heat,
      'total_visitors': totalVisitors,
      'total_gifts': totalGifts,
      'announcement': announcement,
      'tags': tags,
      'allow_guests': allowGuests,
      'allow_chat': allowChat,
      'allow_gifts': allowGifts,
      'allow_mic': allowMic,
      'is_locked': isLocked,
      'is_official': isOfficial,
      'is_recommended': isRecommended,
      'verified': verified,
      'owner_name': ownerName,
      'owner_avatar': ownerAvatar,
      'room_number': roomNumber,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'closed_at': closedAt?.toIso8601String(),
    };
  }
}
