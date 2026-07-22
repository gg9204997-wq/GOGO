import 'package:equatable/equatable.dart';

class GiftModel extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String imageUrl;
  final String? animationUrl;
  final String type;
  final int price;
  final int level;
  final bool isActive;
  final bool isVip;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GiftModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.price,
    required this.level,
    required this.isActive,
    required this.isVip,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.animationUrl,
  });

  factory GiftModel.empty()=>GiftModel(
    id:'',
    name:'',
    imageUrl:'',
    type:'normal',
    price:0,
    level:1,
    isActive:true,
    isVip:false,
    createdAt:DateTime.now(),
    updatedAt:DateTime.now(),
  );

  GiftModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? animationUrl,
    String? type,
    int? price,
    int? level,
    bool? isActive,
    bool? isVip,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GiftModel(
      id:id??this.id,
      name:name??this.name,
      description:description??this.description,
      imageUrl:imageUrl??this.imageUrl,
      animationUrl:animationUrl??this.animationUrl,
      type:type??this.type,
      price:price??this.price,
      level:level??this.level,
      isActive:isActive??this.isActive,
      isVip:isVip??this.isVip,
      createdAt:createdAt??this.createdAt,
      updatedAt:updatedAt??this.updatedAt,
    );
  }

  factory GiftModel.fromMap(Map<String,dynamic> map){
    return GiftModel(
      id:map['id']?.toString()??'',
      name:map['name']?.toString()??'',
      description:map['description']?.toString(),
      imageUrl:map['image_url']?.toString()??'',
      animationUrl:map['animation_url']?.toString(),
      type:map['type']?.toString()??'normal',
      price:(map['price'] as num?)?.toInt()??0,
      level:(map['level'] as num?)?.toInt()??1,
      isActive:map['is_active'] as bool? ?? true,
      isVip:map['is_vip'] as bool? ?? false,
      createdAt:DateTime.tryParse(map['created_at']?.toString()??'')??DateTime.now(),
      updatedAt:DateTime.tryParse(map['updated_at']?.toString()??'')??DateTime.now(),
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'name':name,
    'description':description,
    'image_url':imageUrl,
    'animation_url':animationUrl,
    'type':type,
    'price':price,
    'level':level,
    'is_active':isActive,
    'is_vip':isVip,
    'created_at':createdAt.toIso8601String(),
    'updated_at':updatedAt.toIso8601String(),
  };

  factory GiftModel.fromJson(Map<String,dynamic> json)=>GiftModel.fromMap(json);

  Map<String,dynamic> toJson()=>toMap();

  bool get hasAnimation=>animationUrl?.isNotEmpty??false;

  bool get canSend=>isActive;

  @override
  List<Object?> get props=>[
    id,
    name,
    description,
    imageUrl,
    animationUrl,
    type,
    price,
    level,
    isActive,
    isVip,
    createdAt,
    updatedAt,
  ];
}