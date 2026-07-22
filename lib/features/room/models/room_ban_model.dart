import 'package:equatable/equatable.dart';

class RoomBanModel extends Equatable {
  final String id;
  final String roomId;
  final String userId;
  final String? bannedBy;
  final String? reason;
  final bool permanent;
  final bool active;
  final DateTime? expiresAt;
  final String? liftedBy;
  final DateTime? liftedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomBanModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.permanent,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    this.bannedBy,
    this.reason,
    this.expiresAt,
    this.liftedBy,
    this.liftedAt,
  });

  factory RoomBanModel.empty()=>RoomBanModel(
    id:'',
    roomId:'',
    userId:'',
    permanent:false,
    active:true,
    createdAt:DateTime.now(),
    updatedAt:DateTime.now(),
  );

  factory RoomBanModel.fromMap(Map<String,dynamic> map){
    return RoomBanModel(
      id:map['id']?.toString()??'',
      roomId:map['room_id']?.toString()??'',
      userId:map['user_id']?.toString()??'',
      bannedBy:map['banned_by']?.toString(),
      reason:map['reason']?.toString(),
      permanent:map['permanent'] as bool? ?? false,
      active:map['active'] as bool? ?? true,
      expiresAt:map['expires_at']!=null
          ?DateTime.tryParse(map['expires_at'].toString())
          :null,
      liftedBy:map['lifted_by']?.toString(),
      liftedAt:map['lifted_at']!=null
          ?DateTime.tryParse(map['lifted_at'].toString())
          :null,
      createdAt:DateTime.tryParse(map['created_at']?.toString()??'')??DateTime.now(),
      updatedAt:DateTime.tryParse(map['updated_at']?.toString()??'')??DateTime.now(),
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'room_id':roomId,
    'user_id':userId,
    'banned_by':bannedBy,
    'reason':reason,
    'permanent':permanent,
    'active':active,
    'expires_at':expiresAt?.toIso8601String(),
    'lifted_by':liftedBy,
    'lifted_at':liftedAt?.toIso8601String(),
    'created_at':createdAt.toIso8601String(),
    'updated_at':updatedAt.toIso8601String(),
  };

  factory RoomBanModel.fromJson(Map<String,dynamic> json)=>RoomBanModel.fromMap(json);

  Map<String,dynamic> toJson()=>toMap();

  RoomBanModel copyWith({
    String? id,
    String? roomId,
    String? userId,
    String? bannedBy,
    String? reason,
    bool? permanent,
    bool? active,
    DateTime? expiresAt,
    String? liftedBy,
    DateTime? liftedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }){
    return RoomBanModel(
      id:id??this.id,
      roomId:roomId??this.roomId,
      userId:userId??this.userId,
      bannedBy:bannedBy??this.bannedBy,
      reason:reason??this.reason,
      permanent:permanent??this.permanent,
      active:active??this.active,
      expiresAt:expiresAt??this.expiresAt,
      liftedBy:liftedBy??this.liftedBy,
      liftedAt:liftedAt??this.liftedAt,
      createdAt:createdAt??this.createdAt,
      updatedAt:updatedAt??this.updatedAt,
    );
  }

  bool get isBanned=>active;
  bool get isPermanent=>permanent;

  @override
  List<Object?> get props=>[
    id,
    roomId,
    userId,
    bannedBy,
    reason,
    permanent,
    active,
    expiresAt,
    liftedBy,
    liftedAt,
    createdAt,
    updatedAt,
  ];
}