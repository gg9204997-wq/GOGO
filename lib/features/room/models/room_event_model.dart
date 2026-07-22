import 'package:equatable/equatable.dart';

class RoomEventModel extends Equatable {
  final String id;
  final String roomId;
  final String createdBy;
  final String title;
  final String? description;
  final String eventType;
  final String? banner;
  final DateTime? startTime;
  final DateTime? endTime;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomEventModel({
    required this.id,
    required this.roomId,
    required this.createdBy,
    required this.title,
    required this.eventType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.banner,
    this.startTime,
    this.endTime,
  });

  factory RoomEventModel.empty()=>RoomEventModel(
    id:'',
    roomId:'',
    createdBy:'',
    title:'',
    eventType:'normal',
    status:'active',
    createdAt:DateTime.now(),
    updatedAt:DateTime.now(),
  );

  factory RoomEventModel.fromMap(Map<String,dynamic> map){
    return RoomEventModel(
      id:map['id']?.toString()??'',
      roomId:map['room_id']?.toString()??'',
      createdBy:map['created_by']?.toString()??'',
      title:map['title']?.toString()??'',
      description:map['description']?.toString(),
      eventType:map['event_type']?.toString()??'normal',
      banner:map['banner']?.toString(),
      startTime:map['start_time']!=null
          ?DateTime.tryParse(map['start_time'].toString())
          :null,
      endTime:map['end_time']!=null
          ?DateTime.tryParse(map['end_time'].toString())
          :null,
      status:map['status']?.toString()??'active',
      createdAt:DateTime.tryParse(map['created_at']?.toString()??'')??DateTime.now(),
      updatedAt:DateTime.tryParse(map['updated_at']?.toString()??'')??DateTime.now(),
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'room_id':roomId,
    'created_by':createdBy,
    'title':title,
    'description':description,
    'event_type':eventType,
    'banner':banner,
    'start_time':startTime?.toIso8601String(),
    'end_time':endTime?.toIso8601String(),
    'status':status,
    'created_at':createdAt.toIso8601String(),
    'updated_at':updatedAt.toIso8601String(),
  };

  factory RoomEventModel.fromJson(Map<String,dynamic> json)=>RoomEventModel.fromMap(json);

  Map<String,dynamic> toJson()=>toMap();

  RoomEventModel copyWith({
    String? id,
    String? roomId,
    String? createdBy,
    String? title,
    String? description,
    String? eventType,
    String? banner,
    DateTime? startTime,
    DateTime? endTime,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }){
    return RoomEventModel(
      id:id??this.id,
      roomId:roomId??this.roomId,
      createdBy:createdBy??this.createdBy,
      title:title??this.title,
      description:description??this.description,
      eventType:eventType??this.eventType,
      banner:banner??this.banner,
      startTime:startTime??this.startTime,
      endTime:endTime??this.endTime,
      status:status??this.status,
      createdAt:createdAt??this.createdAt,
      updatedAt:updatedAt??this.updatedAt,
    );
  }

  bool get isActive=>status=='active';

  @override
  List<Object?> get props=>[
    id,
    roomId,
    createdBy,
    title,
    description,
    eventType,
    banner,
    startTime,
    endTime,
    status,
    createdAt,
    updatedAt,
  ];
}