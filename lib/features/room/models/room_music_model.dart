import 'package:equatable/equatable.dart';

class RoomMusicModel extends Equatable {
  final String id;
  final String roomId;
  final String addedBy;
  final String title;
  final String? artist;
  final String url;
  final String? cover;
  final int duration;
  final bool isPlaying;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomMusicModel({
    required this.id,
    required this.roomId,
    required this.addedBy,
    required this.title,
    required this.url,
    required this.duration,
    required this.isPlaying,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.artist,
    this.cover,
  });

  factory RoomMusicModel.empty() => RoomMusicModel(
        id: '',
        roomId: '',
        addedBy: '',
        title: '',
        url: '',
        duration: 0,
        isPlaying: false,
        position: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory RoomMusicModel.fromMap(Map<String, dynamic> map) {
    return RoomMusicModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      addedBy: map['added_by']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      artist: map['artist']?.toString(),
      url: map['url']?.toString() ?? '',
      cover: map['cover']?.toString(),
      duration: (map['duration'] as num?)?.toInt() ?? 0,
      isPlaying: map['is_playing'] as bool? ?? false,
      position: (map['position'] as num?)?.toInt() ?? 0,
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

  Map<String, dynamic> toMap() => {
        'id': id,
        'room_id': roomId,
        'added_by': addedBy,
        'title': title,
        'artist': artist,
        'url': url,
        'cover': cover,
        'duration': duration,
        'is_playing': isPlaying,
        'position': position,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory RoomMusicModel.fromJson(Map<String, dynamic> json) =>
      RoomMusicModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  RoomMusicModel copyWith({
    String? id,
    String? roomId,
    String? addedBy,
    String? title,
    String? artist,
    String? url,
    String? cover,
    int? duration,
    bool? isPlaying,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomMusicModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      addedBy: addedBy ?? this.addedBy,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      url: url ?? this.url,
      cover: cover ?? this.cover,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasCover => cover?.isNotEmpty == true;

  bool get hasArtist => artist?.isNotEmpty == true;

  @override
  List<Object?> get props => [
        id,
        roomId,
        addedBy,
        title,
        artist,
        url,
        cover,
        duration,
        isPlaying,
        position,
        createdAt,
        updatedAt,
      ];
}