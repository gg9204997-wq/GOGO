import 'package:flutter/foundation.dart';

@immutable
class LeaderboardItemModel {
  final String id;
  final String title;
  final String frameImage;
  final String backgroundImage;
  final int totalSupport;
  final List<String> topUsers;

  const LeaderboardItemModel({
    required this.id,
    required this.title,
    required this.frameImage,
    required this.backgroundImage,
    required this.totalSupport,
    required this.topUsers,
  });

  factory LeaderboardItemModel.fromMap(Map<String, dynamic> json) {
    return LeaderboardItemModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      frameImage: (json['frame_image'] ?? '').toString(),
      backgroundImage: (json['background_image'] ?? '').toString(),
      totalSupport: (json['total_support'] as num?)?.toInt() ?? 0,
      topUsers: (json['top_users'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'frame_image': frameImage,
      'background_image': backgroundImage,
      'total_support': totalSupport,
      'top_users': topUsers,
    };
  }
}
