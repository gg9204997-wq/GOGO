import 'package:equatable/equatable.dart';

class RoomStatisticsModel extends Equatable {
  final String roomId;

  final int totalGifts;
  final int totalCoins;
  final int totalDiamonds;

  final int totalMessages;
  final int totalVisitors;
  final int peakOnline;

  final int totalVoiceMinutes;
  final int totalSessions;

  final int todayGifts;
  final int todayCoins;
  final int todayDiamonds;

  final DateTime? lastActivityAt;

  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomStatisticsModel({
    required this.roomId,
    required this.totalGifts,
    required this.totalCoins,
    required this.totalDiamonds,
    required this.totalMessages,
    required this.totalVisitors,
    required this.peakOnline,
    required this.totalVoiceMinutes,
    required this.totalSessions,
    required this.todayGifts,
    required this.todayCoins,
    required this.todayDiamonds,
    this.lastActivityAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomStatisticsModel.empty(String roomId) {
    return RoomStatisticsModel(
      roomId: roomId,
      totalGifts: 0,
      totalCoins: 0,
      totalDiamonds: 0,
      totalMessages: 0,
      totalVisitors: 0,
      peakOnline: 0,
      totalVoiceMinutes: 0,
      totalSessions: 0,
      todayGifts: 0,
      todayCoins: 0,
      todayDiamonds: 0,
      lastActivityAt: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory RoomStatisticsModel.fromMap(Map<String, dynamic> map) {
    return RoomStatisticsModel(
      roomId: map['room_id']?.toString() ?? '',

      totalGifts: (map['total_gifts'] as num?)?.toInt() ?? 0,
      totalCoins: (map['total_coins'] as num?)?.toInt() ?? 0,
      totalDiamonds: (map['total_diamonds'] as num?)?.toInt() ?? 0,

      totalMessages: (map['total_messages'] as num?)?.toInt() ?? 0,
      totalVisitors: (map['total_visitors'] as num?)?.toInt() ?? 0,
      peakOnline: (map['peak_online'] as num?)?.toInt() ?? 0,

      totalVoiceMinutes:
          (map['total_voice_minutes'] as num?)?.toInt() ?? 0,

      totalSessions:
          (map['total_sessions'] as num?)?.toInt() ?? 0,

      todayGifts: (map['today_gifts'] as num?)?.toInt() ?? 0,
      todayCoins: (map['today_coins'] as num?)?.toInt() ?? 0,
      todayDiamonds:
          (map['today_diamonds'] as num?)?.toInt() ?? 0,

      lastActivityAt: map['last_activity_at'] != null
          ? DateTime.tryParse(map['last_activity_at'].toString())
          : null,

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
      'room_id': roomId,
      'total_gifts': totalGifts,
      'total_coins': totalCoins,
      'total_diamonds': totalDiamonds,
      'total_messages': totalMessages,
      'total_visitors': totalVisitors,
      'peak_online': peakOnline,
      'total_voice_minutes': totalVoiceMinutes,
      'total_sessions': totalSessions,
      'today_gifts': todayGifts,
      'today_coins': todayCoins,
      'today_diamonds': todayDiamonds,
      'last_activity_at': lastActivityAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory RoomStatisticsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return RoomStatisticsModel.fromMap(json);
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  RoomStatisticsModel copyWith({
    String? roomId,
    int? totalGifts,
    int? totalCoins,
    int? totalDiamonds,
    int? totalMessages,
    int? totalVisitors,
    int? peakOnline,
    int? totalVoiceMinutes,
    int? totalSessions,
    int? todayGifts,
    int? todayCoins,
    int? todayDiamonds,
    DateTime? lastActivityAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomStatisticsModel(
      roomId: roomId ?? this.roomId,
      totalGifts: totalGifts ?? this.totalGifts,
      totalCoins: totalCoins ?? this.totalCoins,
      totalDiamonds: totalDiamonds ?? this.totalDiamonds,
      totalMessages: totalMessages ?? this.totalMessages,
      totalVisitors: totalVisitors ?? this.totalVisitors,
      peakOnline: peakOnline ?? this.peakOnline,
      totalVoiceMinutes:
          totalVoiceMinutes ?? this.totalVoiceMinutes,
      totalSessions:
          totalSessions ?? this.totalSessions,
      todayGifts: todayGifts ?? this.todayGifts,
      todayCoins: todayCoins ?? this.todayCoins,
      todayDiamonds:
          todayDiamonds ?? this.todayDiamonds,
      lastActivityAt:
          lastActivityAt ?? this.lastActivityAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        roomId,
        totalGifts,
        totalCoins,
        totalDiamonds,
        totalMessages,
        totalVisitors,
        peakOnline,
        totalVoiceMinutes,
        totalSessions,
        todayGifts,
        todayCoins,
        todayDiamonds,
        lastActivityAt,
        createdAt,
        updatedAt,
      ];
}