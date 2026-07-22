import 'package:equatable/equatable.dart';

class RoomRequestModel extends Equatable {
  final String id;
  final String roomId;
  final String userId;

  final String requestType;
  final String status;

  final int? seatNumber;

  final String? handledBy;
  final String? note;

  final DateTime? handledAt;
  final DateTime createdAt;

  const RoomRequestModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.requestType,
    required this.status,
    this.seatNumber,
    this.handledBy,
    this.note,
    this.handledAt,
    required this.createdAt,
  });

  factory RoomRequestModel.empty() {
    return RoomRequestModel(
      id: '',
      roomId: '',
      userId: '',
      requestType: 'mic',
      status: 'pending',
      seatNumber: null,
      handledBy: null,
      note: null,
      handledAt: null,
      createdAt: DateTime.now(),
    );
  }

  factory RoomRequestModel.fromMap(Map<String, dynamic> map) {
    return RoomRequestModel(
      id: map['id']?.toString() ?? '',
      roomId: map['room_id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      requestType: map['request_type']?.toString() ?? 'mic',
      status: map['status']?.toString() ?? 'pending',

      seatNumber: (map['seat_number'] as num?)?.toInt(),

      handledBy: map['handled_by']?.toString(),
      note: map['note']?.toString(),

      handledAt: map['handled_at'] != null
          ? DateTime.tryParse(map['handled_at'].toString())
          : null,

      createdAt: DateTime.tryParse(
            map['created_at']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomId,
      'user_id': userId,
      'request_type': requestType,
      'status': status,
      'seat_number': seatNumber,
      'handled_by': handledBy,
      'note': note,
      'handled_at': handledAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory RoomRequestModel.fromJson(Map<String, dynamic> json) {
    return RoomRequestModel.fromMap(json);
  }

  Map<String, dynamic> toJson() => toMap();

  RoomRequestModel copyWith({
    String? id,
    String? roomId,
    String? userId,
    String? requestType,
    String? status,
    int? seatNumber,
    String? handledBy,
    String? note,
    DateTime? handledAt,
    DateTime? createdAt,
  }) {
    return RoomRequestModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      requestType: requestType ?? this.requestType,
      status: status ?? this.status,
      seatNumber: seatNumber ?? this.seatNumber,
      handledBy: handledBy ?? this.handledBy,
      note: note ?? this.note,
      handledAt: handledAt ?? this.handledAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isPending => status == 'pending';

  bool get isAccepted => status == 'accepted';

  bool get isRejected => status == 'rejected';

  @override
  List<Object?> get props => [
        id,
        roomId,
        userId,
        requestType,
        status,
        seatNumber,
        handledBy,
        note,
        handledAt,
        createdAt,
      ];
}