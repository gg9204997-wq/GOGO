import 'package:flutter/foundation.dart';

@immutable
class TopHostModel {
  final String roomId;
  final String ownerId;

  final String roomName;
  final String ownerName;
  final String ownerAvatar;
  final String roomCover;

  final int totalVisitors;
  final int peakOnline;
  final int totalDiamonds;

  const TopHostModel({
    required this.roomId,
    required this.ownerId,
    required this.roomName,
    required this.ownerName,
    required this.ownerAvatar,
    required this.roomCover,
    required this.totalVisitors,
    required this.peakOnline,
    required this.totalDiamonds,
  });

  factory TopHostModel.fromMap(
    Map<String, dynamic> json,
  ) {
    final room =
        json['rooms'] as Map<String, dynamic>? ?? {};

    final profile =
        room['profiles'] as Map<String, dynamic>? ?? {};

    return TopHostModel(
      roomId:
          (json['room_id'] ?? '').toString(),

      ownerId:
          (room['owner_id'] ?? '').toString(),

      roomName:
          (room['room_name'] ?? '').toString(),

      roomCover:
          (room['room_cover'] ?? '').toString(),

      ownerName:
          (profile['name'] ?? '').toString(),

      ownerAvatar:
          (profile['avatar'] ?? '').toString(),

      totalVisitors:
          (json['total_visitors'] as num?)
                  ?.toInt() ??
              0,

      peakOnline:
          (json['peak_online'] as num?)
                  ?.toInt() ??
              0,

      totalDiamonds:
          (json['total_diamonds'] as num?)
                  ?.toInt() ??
              0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'room_id': roomId,
      'owner_id': ownerId,
      'room_name': roomName,
      'owner_name': ownerName,
      'owner_avatar': ownerAvatar,
      'room_cover': roomCover,
      'total_visitors': totalVisitors,
      'peak_online': peakOnline,
      'total_diamonds': totalDiamonds,
    };
  }
}