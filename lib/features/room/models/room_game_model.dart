import 'package:equatable/equatable.dart';

class RoomGameModel extends Equatable {
  final String id;
  final String roomId;
  final String startedBy;
  final String gameType;
  final String? title;
  final Map<String, dynamic> settings;
  final List<dynamic> players;
  final String? winnerId;
  final String status;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;

  const RoomGameModel({
    required this.id,
    required this.roomId,
    required this.startedBy,
    required this.gameType,
    required this.settings,
    required this.players,
    required this.status,
    required this.createdAt,
    this.title,
    this.winnerId,
    this.startedAt,
    this.endedAt,
  });

  factory RoomGameModel.empty() => RoomGameModel(
        id: '',
        roomId: '',
        startedBy: '',
        gameType: '',
        settings: const {},
        players: const [],
        status: 'waiting',
        createdAt: DateTime.now(),
      );

  factory RoomGameModel.fromMap(Map<String, dynamic> map) {
    final settingsData = map['settings'];
    final playersData = map['players'];

    return RoomGameModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      startedBy: map['started_by']?.toString() ?? '',
      gameType: map['game_type']?.toString() ?? '',
      title: map['title']?.toString(),
      settings: settingsData is Map
          ? settingsData.map(
              (key, value) => MapEntry(key.toString(), value),
            )
          : <String, dynamic>{},
      players: playersData is List
          ? List<dynamic>.from(playersData)
          : <dynamic>[],
      winnerId: map['winner_id']?.toString(),
      status: map['status']?.toString() ?? 'waiting',
      startedAt: map['started_at'] != null
          ? DateTime.tryParse(map['started_at'].toString())
          : null,
      endedAt: map['ended_at'] != null
          ? DateTime.tryParse(map['ended_at'].toString())
          : null,
      createdAt: DateTime.tryParse(
            map['created_at']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'room_id': roomId,
        'started_by': startedBy,
        'game_type': gameType,
        'title': title,
        'settings': settings,
        'players': players,
        'winner_id': winnerId,
        'status': status,
        'started_at': startedAt?.toIso8601String(),
        'ended_at': endedAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
      };

  factory RoomGameModel.fromJson(Map<String, dynamic> json) =>
      RoomGameModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  RoomGameModel copyWith({
    String? id,
    String? roomId,
    String? startedBy,
    String? gameType,
    String? title,
    Map<String, dynamic>? settings,
    List<dynamic>? players,
    String? winnerId,
    String? status,
    DateTime? startedAt,
    DateTime? endedAt,
    DateTime? createdAt,
  }) {
    return RoomGameModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      startedBy: startedBy ?? this.startedBy,
      gameType: gameType ?? this.gameType,
      title: title ?? this.title,
      settings: settings ?? this.settings,
      players: players ?? this.players,
      winnerId: winnerId ?? this.winnerId,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isWaiting => status == 'waiting';
  bool get isRunning => status == 'running';
  bool get isFinished => status == 'finished';

  @override
  List<Object?> get props => [
        id,
        roomId,
        startedBy,
        gameType,
        title,
        settings,
        players,
        winnerId,
        status,
        startedAt,
        endedAt,
        createdAt,
      ];
}