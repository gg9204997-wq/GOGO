import 'package:equatable/equatable.dart';

class RoomBackgroundModel extends Equatable {
  final String id;
  final String roomId;
  final String imageUrl;
  final String thumbnailUrl;
  final String videoUrl;
  final String type;
  final bool isAnimated;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomBackgroundModel({
    required this.id,
    required this.roomId,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.type,
    required this.isAnimated,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomBackgroundModel.empty()=>RoomBackgroundModel(
    id:'',
    roomId:'',
    imageUrl:'',
    thumbnailUrl:'',
    videoUrl:'',
    type:'image',
    isAnimated:false,
    isDefault:true,
    createdAt:DateTime.now(),
    updatedAt:DateTime.now(),
  );

  RoomBackgroundModel copyWith({
    String? id,
    String? roomId,
    String? imageUrl,
    String? thumbnailUrl,
    String? videoUrl,
    String? type,
    bool? isAnimated,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }){
    return RoomBackgroundModel(
      id:id??this.id,
      roomId:roomId??this.roomId,
      imageUrl:imageUrl??this.imageUrl,
      thumbnailUrl:thumbnailUrl??this.thumbnailUrl,
      videoUrl:videoUrl??this.videoUrl,
      type:type??this.type,
      isAnimated:isAnimated??this.isAnimated,
      isDefault:isDefault??this.isDefault,
      createdAt:createdAt??this.createdAt,
      updatedAt:updatedAt??this.updatedAt,
    );
  }

  factory RoomBackgroundModel.fromMap(Map<String,dynamic> map){
    return RoomBackgroundModel(
      id:map['id']?.toString()??'',
      roomId:map['room_id']?.toString()??'',
      imageUrl:map['image_url']?.toString()??'',
      thumbnailUrl:map['thumbnail_url']?.toString()??'',
      videoUrl:map['video_url']?.toString()??'',
      type:map['type']?.toString()??'image',
      isAnimated:map['is_animated'] as bool? ?? false,
      isDefault:map['is_default'] as bool? ?? true,
      createdAt:DateTime.tryParse(map['created_at']?.toString()??'')??DateTime.now(),
      updatedAt:DateTime.tryParse(map['updated_at']?.toString()??'')??DateTime.now(),
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'room_id':roomId,
    'image_url':imageUrl,
    'thumbnail_url':thumbnailUrl,
    'video_url':videoUrl,
    'type':type,
    'is_animated':isAnimated,
    'is_default':isDefault,
    'created_at':createdAt.toIso8601String(),
    'updated_at':updatedAt.toIso8601String(),
  };

  factory RoomBackgroundModel.fromJson(Map<String,dynamic> json)=>RoomBackgroundModel.fromMap(json);

  Map<String,dynamic> toJson()=>toMap();

  bool get hasVideo=>videoUrl.isNotEmpty;
  bool get hasImage=>imageUrl.isNotEmpty;
  bool get isAnimation=>isAnimated||type=='animation'||hasVideo;

  @override
  List<Object?> get props=>[
    id,
    roomId,
    imageUrl,
    thumbnailUrl,
    videoUrl,
    type,
    isAnimated,
    isDefault,
    createdAt,
    updatedAt,
  ];

  @override
  String toString()=>"RoomBackgroundModel(type: $type, animated: $isAnimated)";
}