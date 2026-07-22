import 'package:equatable/equatable.dart';

class RoomLevelHistoryModel extends Equatable {
  final String id;
  final String roomId;
  final int oldLevel;
  final int newLevel;
  final int xpAdded;
  final String? reason;
  final String? createdBy;
  final DateTime createdAt;

  const RoomLevelHistoryModel({
    required this.id,
    required this.roomId,
    required this.oldLevel,
    required this.newLevel,
    required this.xpAdded,
    required this.createdAt,
    this.reason,
    this.createdBy,
  });

  factory RoomLevelHistoryModel.empty()=>RoomLevelHistoryModel(
    id:'',
    roomId:'',
    oldLevel:1,
    newLevel:1,
    xpAdded:0,
    createdAt:DateTime.now(),
  );

  factory RoomLevelHistoryModel.fromMap(Map<String,dynamic> map){
    return RoomLevelHistoryModel(
      id:map['id']?.toString()??'',
      roomId:map['room_id']?.toString()??'',
      oldLevel:(map['old_level'] as num?)?.toInt()??1,
      newLevel:(map['new_level'] as num?)?.toInt()??1,
      xpAdded:(map['xp_added'] as num?)?.toInt()??0,
      reason:map['reason']?.toString(),
      createdBy:map['created_by']?.toString(),
      createdAt:DateTime.tryParse(map['created_at']?.toString()??'')??DateTime.now(),
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'room_id':roomId,
    'old_level':oldLevel,
    'new_level':newLevel,
    'xp_added':xpAdded,
    'reason':reason,
    'created_by':createdBy,
    'created_at':createdAt.toIso8601String(),
  };

  factory RoomLevelHistoryModel.fromJson(Map<String,dynamic> json)=>RoomLevelHistoryModel.fromMap(json);

  Map<String,dynamic> toJson()=>toMap();

  RoomLevelHistoryModel copyWith({
    String? id,
    String? roomId,
    int? oldLevel,
    int? newLevel,
    int? xpAdded,
    String? reason,
    String? createdBy,
    DateTime? createdAt,
  }){
    return RoomLevelHistoryModel(
      id:id??this.id,
      roomId:roomId??this.roomId,
      oldLevel:oldLevel??this.oldLevel,
      newLevel:newLevel??this.newLevel,
      xpAdded:xpAdded??this.xpAdded,
      reason:reason??this.reason,
      createdBy:createdBy??this.createdBy,
      createdAt:createdAt??this.createdAt,
    );
  }

  int get levelIncrease=>newLevel-oldLevel;

  bool get hasLevelUp=>newLevel>oldLevel;

  @override
  List<Object?> get props=>[
    id,
    roomId,
    oldLevel,
    newLevel,
    xpAdded,
    reason,
    createdBy,
    createdAt,
  ];
}