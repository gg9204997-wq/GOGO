import 'package:equatable/equatable.dart';

class RoomRankModel extends Equatable {
  final String id;
  final String roomId;
  final String userId;

  final String username;
  final String nickname;
  final String avatarUrl;

  final String rankType;

  final int rank;
  final int score;

  final int gifts;
  final int giftValue;

  final int messages;
  final int speakingTime;

  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomRankModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.username,
    required this.nickname,
    required this.avatarUrl,
    required this.rankType,
    required this.rank,
    required this.score,
    required this.gifts,
    required this.giftValue,
    required this.messages,
    required this.speakingTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomRankModel.empty() {
    return RoomRankModel(
      id: '',
      roomId: '',
      userId: '',
      username: '',
      nickname: '',
      avatarUrl: '',
      rankType: 'user',
      rank: 0,
      score: 0,
      gifts: 0,
      giftValue: 0,
      messages: 0,
      speakingTime: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory RoomRankModel.fromMap(Map<String, dynamic> map) {
    return RoomRankModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',

      username: map['username']?.toString() ?? '',
      nickname: map['nickname']?.toString() ?? '',
      avatarUrl: map['avatar_url']?.toString() ?? '',

      rankType: map['rank_type']?.toString() ?? 'user',

      rank: (map['rank'] as num?)?.toInt() ?? 0,
      score: (map['score'] as num?)?.toInt() ?? 0,

      gifts: (map['gifts'] as num?)?.toInt() ?? 0,
      giftValue: (map['gift_value'] as num?)?.toInt() ?? 0,

      messages: (map['messages'] as num?)?.toInt() ?? 0,
      speakingTime: (map['speaking_time'] as num?)?.toInt() ?? 0,

      createdAt: DateTime.tryParse(
            map['created_at']?.toString() ?? '',
          ) ??
          DateTime.now(),

      updatedAt: DateTime.tryParse(
            map['updated_at']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomId,
      'user_id': userId,
      'username': username,
      'nickname': nickname,
      'avatar_url': avatarUrl,
      'rank_type': rankType,
      'rank': rank,
      'score': score,
      'gifts': gifts,
      'gift_value': giftValue,
      'messages': messages,
      'speaking_time': speakingTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory RoomRankModel.fromJson(Map<String, dynamic> json) {
    return RoomRankModel.fromMap(json);
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  RoomRankModel copyWith({
    String? id,
    String? roomId,
    String? userId,
    String? username,
    String? nickname,
    String? avatarUrl,
    String? rankType,
    int? rank,
    int? score,
    int? gifts,
    int? giftValue,
    int? messages,
    int? speakingTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomRankModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rankType: rankType ?? this.rankType,
      rank: rank ?? this.rank,
      score: score ?? this.score,
      gifts: gifts ?? this.gifts,
      giftValue: giftValue ?? this.giftValue,
      messages: messages ?? this.messages,
      speakingTime: speakingTime ?? this.speakingTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isTopRank => rank > 0 && rank <= 3;

  bool get isTopGifter => rankType == 'gifter';

  bool get isTopSpeaker => rankType == 'speaker';

  bool get isTopUser => rankType == 'user';

  String get displayName {
    if (nickname.isNotEmpty) return nickname;
    if (username.isNotEmpty) return username;
    return 'User';
  }

  @override
  List<Object?> get props => [
        id,
        roomId,
        userId,
        username,
        nickname,
        avatarUrl,
        rankType,
        rank,
        score,
        gifts,
        giftValue,
        messages,
        speakingTime,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'RoomRankModel(user: $displayName, rank: $rank)';
  }
}