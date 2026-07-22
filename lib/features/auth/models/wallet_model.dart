import 'package:flutter/foundation.dart';

@immutable
class WalletModel {
  final String id;
  final String userId;

  final int coins;
  final int diamonds;

  final int totalRecharge;
  final int totalSpent;
  final int totalReceived;

  final DateTime createdAt;
  final DateTime updatedAt;

  const WalletModel({
    required this.id,
    required this.userId,
    required this.coins,
    required this.diamonds,
    required this.totalRecharge,
    required this.totalSpent,
    required this.totalReceived,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletModel.fromMap(Map<String, dynamic> map) {
  return WalletModel(
    id: (map['id'] as String?) ?? '',
    userId: (map['user_id'] as String?) ?? '',

    coins: (map['coins'] as num?)?.toInt() ?? 0,
    diamonds: (map['diamonds'] as num?)?.toInt() ?? 0,

    totalRecharge:
        (map['total_recharge'] as num?)?.toInt() ?? 0,

    totalSpent:
        (map['total_spent'] as num?)?.toInt() ?? 0,

    totalReceived:
        (map['total_received'] as num?)?.toInt() ?? 0,

    createdAt: map['created_at'] != null
        ? DateTime.parse(map['created_at'].toString())
        : DateTime.now(),

    updatedAt: map['updated_at'] != null
        ? DateTime.parse(map['updated_at'].toString())
        : DateTime.now(),
  );
}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,

      'coins': coins,
      'diamonds': diamonds,

      'total_recharge': totalRecharge,
      'total_spent': totalSpent,
      'total_received': totalReceived,

      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  WalletModel copyWith({
    String? id,
    String? userId,
    int? coins,
    int? diamonds,
    int? totalRecharge,
    int? totalSpent,
    int? totalReceived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WalletModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      coins: coins ?? this.coins,
      diamonds: diamonds ?? this.diamonds,
      totalRecharge: totalRecharge ?? this.totalRecharge,
      totalSpent: totalSpent ?? this.totalSpent,
      totalReceived: totalReceived ?? this.totalReceived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}