import 'package:flutter/foundation.dart';

@immutable
class ExplorePostModel {
  final String id;
  final String username;
  final String userAvatar;
  final int userLevel;
  final int vipLevel;
  final String contentText;
  final String postImage;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByMe;

  const ExplorePostModel({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.userLevel,
    required this.vipLevel,
    required this.contentText,
    required this.postImage,
    required this.likesCount,
    required this.commentsCount,
    required this.isLikedByMe,
  });

  factory ExplorePostModel.fromMap(Map<String, dynamic> json) {
    return ExplorePostModel(
      id: (json['id'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      userAvatar: (json['user_avatar'] ?? '').toString(),
      userLevel: (json['user_level'] as num?)?.toInt() ?? 1,
      vipLevel: (json['vip_level'] as num?)?.toInt() ?? 0,
      contentText: (json['content_text'] ?? '').toString(),
      postImage: (json['post_image'] ?? '').toString(),
      likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
      commentsCount: (json['comments_count'] as num?)?.toInt() ?? 0,
      isLikedByMe: (json['is_liked_by_me'] as bool?) ?? false,
    );
  }
}
