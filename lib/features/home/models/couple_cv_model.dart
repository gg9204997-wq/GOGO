import 'package:flutter/foundation.dart';

@immutable
class CoupleCvModel {
  final String id;
  final String partnerOneAvatar;
  final String partnerTwoAvatar;
  final String heartFrame;
  final String eventTitle;
  final int lovePoints;

  const CoupleCvModel({
    required this.id,
    required this.partnerOneAvatar,
    required this.partnerTwoAvatar,
    required this.heartFrame,
    required this.eventTitle,
    required this.lovePoints,
  });

  factory CoupleCvModel.fromMap(Map<String, dynamic> json) {
    return CoupleCvModel(
      id: (json['id'] ?? '').toString(),
      partnerOneAvatar: (json['partner_one_avatar'] ?? '').toString(),
      partnerTwoAvatar: (json['partner_two_avatar'] ?? '').toString(),
      heartFrame: (json['heart_frame'] ?? '').toString(),
      eventTitle: (json['event_title'] ?? '').toString(),
      lovePoints: (json['love_points'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'partner_one_avatar': partnerOneAvatar,
      'partner_two_avatar': partnerTwoAvatar,
      'heart_frame': heartFrame,
      'event_title': eventTitle,
      'love_points': lovePoints,
    };
  }
}
