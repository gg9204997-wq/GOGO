import 'package:equatable/equatable.dart';

class RoomInviteModel extends Equatable {
  final String id;
  final String roomId;
  final String senderId;
  final String receiverId;
  final String status;
  final String? message;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomInviteModel({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.receiverId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.message,
  });

  factory RoomInviteModel.empty()=>RoomInviteModel(
    id:'',
    roomId:'',
    senderId:'',
    receiverId:'',
    status:'pending',
    createdAt:DateTime.now(),
    updatedAt:DateTime.now(),
  );

  factory RoomInviteModel.fromMap(Map<String,dynamic> map){
    return RoomInviteModel(
      id:map['id']?.toString()??'',
      roomId:map['room_id']?.toString()??'',
      senderId:map['sender_id']?.toString()??'',
      receiverId:map['receiver_id']?.toString()??'',
      status:map['status']?.toString()??'pending',
      message:map['message']?.toString(),
      createdAt:DateTime.tryParse(map['created_at']?.toString()??'')??DateTime.now(),
      updatedAt:DateTime.tryParse(map['updated_at']?.toString()??'')??DateTime.now(),
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'room_id':roomId,
    'sender_id':senderId,
    'receiver_id':receiverId,
    'status':status,
    'message':message,
    'created_at':createdAt.toIso8601String(),
    'updated_at':updatedAt.toIso8601String(),
  };

  factory RoomInviteModel.fromJson(Map<String,dynamic> json)=>RoomInviteModel.fromMap(json);

  Map<String,dynamic> toJson()=>toMap();

  RoomInviteModel copyWith({
    String? id,
    String? roomId,
    String? senderId,
    String? receiverId,
    String? status,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }){
    return RoomInviteModel(
      id:id??this.id,
      roomId:roomId??this.roomId,
      senderId:senderId??this.senderId,
      receiverId:receiverId??this.receiverId,
      status:status??this.status,
      message:message??this.message,
      createdAt:createdAt??this.createdAt,
      updatedAt:updatedAt??this.updatedAt,
    );
  }

  bool get isPending=>status=='pending';
  bool get isAccepted=>status=='accepted';
  bool get isRejected=>status=='rejected';

  @override
  List<Object?> get props=>[
    id,
    roomId,
    senderId,
    receiverId,
    status,
    message,
    createdAt,
    updatedAt,
  ];
}