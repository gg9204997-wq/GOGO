import 'package:equatable/equatable.dart';

class MicRequestModel extends Equatable {
  final String id;
  final String roomId;
  final String userId;
  final int? seatNumber;
  final String status;
  final String? handledBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MicRequestModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.seatNumber,
    this.handledBy,
  });

  factory MicRequestModel.empty()=>MicRequestModel(
    id:'',
    roomId:'',
    userId:'',
    status:'pending',
    createdAt:DateTime.now(),
    updatedAt:DateTime.now(),
  );

  MicRequestModel copyWith({
    String? id,
    String? roomId,
    String? userId,
    int? seatNumber,
    String? status,
    String? handledBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }){
    return MicRequestModel(
      id:id??this.id,
      roomId:roomId??this.roomId,
      userId:userId??this.userId,
      seatNumber:seatNumber??this.seatNumber,
      status:status??this.status,
      handledBy:handledBy??this.handledBy,
      createdAt:createdAt??this.createdAt,
      updatedAt:updatedAt??this.updatedAt,
    );
  }

  factory MicRequestModel.fromMap(Map<String,dynamic> map){
    return MicRequestModel(
      id:map['id']?.toString()??'',
      roomId:map['room_id']?.toString()??'',
      userId:map['user_id']?.toString()??'',
      seatNumber:(map['seat_number'] as num?)?.toInt(),
      status:map['status']?.toString()??'pending',
      handledBy:map['handled_by']?.toString(),
      createdAt:DateTime.tryParse(map['created_at']?.toString()??'')??DateTime.now(),
      updatedAt:DateTime.tryParse(map['updated_at']?.toString()??'')??DateTime.now(),
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'room_id':roomId,
    'user_id':userId,
    'seat_number':seatNumber,
    'status':status,
    'handled_by':handledBy,
    'created_at':createdAt.toIso8601String(),
    'updated_at':updatedAt.toIso8601String(),
  };

  factory MicRequestModel.fromJson(Map<String,dynamic> json)=>MicRequestModel.fromMap(json);

  Map<String,dynamic> toJson()=>toMap();

  bool get isPending=>status=='pending';
  bool get isAccepted=>status=='accepted';
  bool get isRejected=>status=='rejected';

  @override
  List<Object?> get props=>[
    id,
    roomId,
    userId,
    seatNumber,
    status,
    handledBy,
    createdAt,
    updatedAt,
  ];
}