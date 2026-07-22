import 'package:flutter/foundation.dart';

@immutable
class AgencyModel {
  final String id;
  final String owner;
  final String agencyName;
  final String logo;
  final int level;
  final int income;
  final DateTime createdAt;

  const AgencyModel({
    required this.id,
    required this.owner,
    required this.agencyName,
    required this.logo,
    required this.level,
    required this.income,
    required this.createdAt,
  });

  factory AgencyModel.fromMap(
    Map<String, dynamic> json,
  ) {
    return AgencyModel(
      id: json['id']?.toString() ?? '',

      owner: json['owner']?.toString() ?? '',

      agencyName:
          json['agency_name']?.toString() ?? '',

      logo: json['logo']?.toString() ?? '',

      level: (json['level'] ?? 1) as int,

      income: (json['income'] ?? 0) as int,

      createdAt: json['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(
              json['created_at'].toString(),
            ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner': owner,
      'agency_name': agencyName,
      'logo': logo,
      'level': level,
      'income': income,
      'created_at': createdAt.toIso8601String(),
    };
  }

  AgencyModel copyWith({
    String? id,
    String? owner,
    String? agencyName,
    String? logo,
    int? level,
    int? income,
    DateTime? createdAt,
  }) {
    return AgencyModel(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      agencyName: agencyName ?? this.agencyName,
      logo: logo ?? this.logo,
      level: level ?? this.level,
      income: income ?? this.income,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}