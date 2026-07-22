import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final String id;
  final String ownerId;

  final String roomName;
  final int roomNumber;

  final String? roomCover;
  final String? roomBackground;
  final String? description;

  final String? category;
  final String? language;
  final String? country;

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

  final String? agoraToken;

  final DateTime? closedAt;

  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomModel({
    required this.id,
    required this.ownerId,
    required this.roomName,
    required this.roomNumber,
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
    required this.createdAt,
    required this.updatedAt,
    this.roomCover,
    this.roomBackground,
    this.description,
    this.category,
    this.language,
    this.country,
    this.password,
    this.announcement,
    this.agoraToken,
    this.closedAt,
  });

  factory RoomModel.empty() => RoomModel(
        id: '',
        ownerId: '',
        roomName: '',
        roomNumber: 0,
        roomType: 'public',
        seatCount: 8,
        activeUsers: 0,
        roomLevel: 1,
        heat: 0,
        totalVisitors: 0,
        totalGifts: 0,
        tags: const [],
        allowGuests: true,
        allowChat: true,
        allowGifts: true,
        allowMic: true,
        isLocked: false,
        isOfficial: false,
        isRecommended: false,
        verified: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id']?.toString() ?? '',
      ownerId: map['owner_id']?.toString() ?? '',
      roomName: map['room_name']?.toString() ?? '',
      roomNumber: (map['room_number'] as num?)?.toInt() ?? 0,
      roomCover: map['room_cover']?.toString(),
      roomBackground: map['room_background']?.toString(),
      description: map['description']?.toString(),
      category: map['category']?.toString(),
      language: map['language']?.toString(),
      country: map['country']?.toString(),
      password: map['password']?.toString(),
      roomType: map['room_type']?.toString() ?? 'public',
      seatCount: (map['seat_count'] as num?)?.toInt() ?? 8,
      activeUsers: (map['active_users'] as num?)?.toInt() ?? 0,
      roomLevel: (map['room_level'] as num?)?.toInt() ?? 1,
      heat: (map['heat'] as num?)?.toInt() ?? 0,
      totalVisitors: (map['total_visitors'] as num?)?.toInt() ?? 0,
      totalGifts: (map['total_gifts'] as num?)?.toInt() ?? 0,
      announcement: map['announcement']?.toString(),
      tags: map['tags'] is List
          ? List<String>.from(
              (map['tags'] as List).map((e) => e.toString()),
            )
          : const [],
      allowGuests: map['allow_guests'] as bool? ?? true,
      allowChat: map['allow_chat'] as bool? ?? true,
      allowGifts: map['allow_gifts'] as bool? ?? true,
      allowMic: map['allow_mic'] as bool? ?? true,
      isLocked: map['is_locked'] as bool? ?? false,
      isOfficial: map['is_official'] as bool? ?? false,
      isRecommended: map['is_recommended'] as bool? ?? false,
      verified: map['verified'] as bool? ?? false,
      agoraToken: map['agora_token']?.toString(),
      closedAt: map['closed_at'] != null
          ? DateTime.tryParse(map['closed_at'].toString())
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

  Map<String, dynamic> toMap() => {
        'id': id,
        'owner_id': ownerId,
        'room_name': roomName,
        'room_number': roomNumber,
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
        'agora_token': agoraToken,
        'closed_at': closedAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      RoomModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  RoomModel copyWith({
    String? id,
    String? ownerId,
    String? roomName,
    int? roomNumber,
    String? roomCover,
    String? roomBackground,
    String? description,
    String? category,
    String? language,
    String? country,
    String? password,
    String? roomType,
    int? seatCount,
    int? activeUsers,
    int? roomLevel,
    int? heat,
    int? totalVisitors,
    int? totalGifts,
    String? announcement,
    List<String>? tags,
    bool? allowGuests,
    bool? allowChat,
    bool? allowGifts,
    bool? allowMic,
    bool? isLocked,
    bool? isOfficial,
    bool? isRecommended,
    bool? verified,
    String? agoraToken,
    DateTime? closedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      roomName: roomName ?? this.roomName,
      roomNumber: roomNumber ?? this.roomNumber,
      roomCover: roomCover ?? this.roomCover,
      roomBackground: roomBackground ?? this.roomBackground,
      description: description ?? this.description,
      category: category ?? this.category,
      language: language ?? this.language,
      country: country ?? this.country,
      password: password ?? this.password,
      roomType: roomType ?? this.roomType,
      seatCount: seatCount ?? this.seatCount,
      activeUsers: activeUsers ?? this.activeUsers,
      roomLevel: roomLevel ?? this.roomLevel,
      heat: heat ?? this.heat,
      totalVisitors: totalVisitors ?? this.totalVisitors,
      totalGifts: totalGifts ?? this.totalGifts,
      announcement: announcement ?? this.announcement,
      tags: tags ?? this.tags,
      allowGuests: allowGuests ?? this.allowGuests,
      allowChat: allowChat ?? this.allowChat,
      allowGifts: allowGifts ?? this.allowGifts,
      allowMic: allowMic ?? this.allowMic,
      isLocked: isLocked ?? this.isLocked,
      isOfficial: isOfficial ?? this.isOfficial,
      isRecommended: isRecommended ?? this.isRecommended,
      verified: verified ?? this.verified,
      agoraToken: agoraToken ?? this.agoraToken,
      closedAt: closedAt ?? this.closedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isFull => activeUsers >= seatCount;
  bool get canJoin => !isLocked && !isFull;

  @override
  List<Object?> get props => [
        id,
        ownerId,
        roomName,
        roomNumber,
        roomCover,
        roomBackground,
        description,
        category,
        language,
        country,
        password,
        roomType,
        seatCount,
        activeUsers,
        roomLevel,
        heat,
        totalVisitors,
        totalGifts,
        announcement,
        tags,
        allowGuests,
        allowChat,
        allowGifts,
        allowMic,
        isLocked,
        isOfficial,
        isRecommended,
        verified,
        agoraToken,
        closedAt,
        createdAt,
        updatedAt,
      ];
}