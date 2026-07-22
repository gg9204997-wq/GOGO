import 'package:equatable/equatable.dart';

class RoomNoticeModel extends Equatable {
  final String id;
  final String roomId;
  final String userId;
  final String title;
  final String message;
  final String type;
  final String? icon;
  final bool isActive;
  final bool isPinned;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomNoticeModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    this.icon,
    required this.isActive,
    required this.isPinned,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomNoticeModel.empty()=>RoomNoticeModel(
    id:'',
    roomId:'',
    userId:'',
    title:'',
    message:'',
    type:'system',
    isActive:true,
    isPinned:false,
    createdAt:DateTime.now(),
    updatedAt:DateTime.now(),
  );

  factory RoomNoticeModel.fromMap(Map<String,dynamic> map){
    return RoomNoticeModel(
      id:map['id']?.toString()??'',
      roomId:map['room_id']?.toString()??'',
      userId:map['user_id']?.toString()??'',
      title:map['title']?.toString()??'',
      message:map['message']?.toString()??'',
      type:map['type']?.toString()??'system',
      icon:map['icon']?.toString(),
      isActive:map['is_active']==true,
      isPinned:map['is_pinned']==true,
      expiresAt:map['expires_at']!=null
          ?DateTime.tryParse(map['expires_at'].toString())
          :null,
      createdAt:DateTime.tryParse(map['created_at']?.toString()??'')??DateTime.now(),
      updatedAt:DateTime.tryParse(map['updated_at']?.toString()??'')??DateTime.now(),
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'room_id':roomId,
    'user_id':userId,
    'title':title,
    'message':message,
    'type':type,
    'icon':icon,
    'is_active':isActive,
    'is_pinned':isPinned,
    'expires_at':expiresAt?.toIso8601String(),
    'created_at':createdAt.toIso8601String(),
    'updated_at':updatedAt.toIso8601String(),
  };

  factory RoomNoticeModel.fromJson(Map<String,dynamic> json)=>RoomNoticeModel.fromMap(json);

  Map<String,dynamic> toJson()=>toMap();

  RoomNoticeModel copyWith({
    String? id,
    String? roomId,
    String? userId,
    String? title,
    String? message,
    String? type,
    String? icon,
    bool? isActive,
    bool? isPinned,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }){
    return RoomNoticeModel(
      id:id??this.id,
      roomId:roomId??this.roomId,
      userId:userId??this.userId,
      title:title??this.title,
      message:message??this.message,
      type:type??this.type,
      icon:icon??this.icon,
      isActive:isActive??this.isActive,
      isPinned:isPinned??this.isPinned,
      expiresAt:expiresAt??this.expiresAt,
      createdAt:createdAt??this.createdAt,
      updatedAt:updatedAt??this.updatedAt,
    );
  }

  bool get isExpired=>expiresAt!=null&&DateTime.now().isAfter(expiresAt!);
  bool get visible=>isActive&&!isExpired;
  bool get isSystem=>type=='system';
  bool get isWelcome=>type=='welcome';
  bool get isAnnouncement=>type=='announcement';

  @override
  List<Object?> get props=>[
    id,
    roomId,
    userId,
    title,
    message,
    type,
    icon,
    isActive,
    isPinned,
    expiresAt,
    createdAt,
    updatedAt,
  ];

  @override
  String toString()=>"RoomNoticeModel(title:$title,type:$type)";
}