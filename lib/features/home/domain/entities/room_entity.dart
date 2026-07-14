import 'package:flutter/foundation.dart';

@immutable
class RoomEntity {
  final String id;
  final String roomName;
  final String ownerId;
  final String ownerName;
  final String ownerAvatar;
  final String coverImage;
  final String countryFlag;
  final String category;

  final int members;

  final bool isVip;
  final bool isLive;

  const RoomEntity({
    required this.id,
    required this.roomName,
    required this.ownerId,
    required this.ownerName,
    required this.ownerAvatar,
    required this.coverImage,
    required this.countryFlag,
    required this.category,
    required this.members,
    required this.isVip,
    required this.isLive,
  });

  factory RoomEntity.fromMap(Map<String, dynamic> map) {
    return RoomEntity(
      id: map['id']?.toString() ?? '',
      roomName: map['room_name']?.toString() ?? '',
      ownerId: map['owner_id']?.toString() ?? '',
      ownerName: map['owner_name']?.toString() ?? '',
      ownerAvatar: map['owner_avatar']?.toString() ?? '',
      coverImage: map['cover_image']?.toString() ?? '',
      countryFlag: map['country_flag']?.toString() ?? '🌍',
      category: map['category']?.toString() ?? '',
      members: (map['members'] ?? 0) as int,
      isVip: map['is_vip'] == true,

isLive: map['is_live'] != false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_name': roomName,
      'owner_id': ownerId,
      'owner_name': ownerName,
      'owner_avatar': ownerAvatar,
      'cover_image': coverImage,
      'country_flag': countryFlag,
      'category': category,
      'members': members,
      'is_vip': isVip,
      'is_live': isLive,
    };
  }

  RoomEntity copyWith({
    String? id,
    String? roomName,
    String? ownerId,
    String? ownerName,
    String? ownerAvatar,
    String? coverImage,
    String? countryFlag,
    String? category,
    int? members,
    bool? isVip,
    bool? isLive,
  }) {
    return RoomEntity(
      id: id ?? this.id,
      roomName: roomName ?? this.roomName,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      ownerAvatar: ownerAvatar ?? this.ownerAvatar,
      coverImage: coverImage ?? this.coverImage,
      countryFlag: countryFlag ?? this.countryFlag,
      category: category ?? this.category,
      members: members ?? this.members,
      isVip: isVip ?? this.isVip,
      isLive: isLive ?? this.isLive,
    );
  }
}