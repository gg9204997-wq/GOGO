class WalletModel {
  final String userId;

  final int coins;
  final int diamonds;

  final DateTime createdAt;
  final DateTime updatedAt;

  const WalletModel({
    required this.userId,
    required this.coins,
    required this.diamonds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      userId: map['user_id']?.toString() ?? '',
      coins: (map['coins'] as num?)?.toInt() ?? 0,
      diamonds: (map['diamonds'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(
        map['created_at'].toString(),
      ),
      updatedAt: DateTime.parse(
        map['updated_at'].toString(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'coins': coins,
      'diamonds': diamonds,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  WalletModel copyWith({
    String? userId,
    int? coins,
    int? diamonds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WalletModel(
      userId: userId ?? this.userId,
      coins: coins ?? this.coins,
      diamonds: diamonds ?? this.diamonds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}