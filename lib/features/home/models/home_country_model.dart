import 'package:flutter/foundation.dart';

@immutable
class HomeCountryModel {
  final String id;
  final String name;        // اسم الدولة (مثل: مصر، السعودية)
  final String countryCode; // كود الفلترة للغرف (مثل: eg, sa)
  final String flagUrl;     // رمز العلم أو رابط صورته من الـ Storage

  const HomeCountryModel({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.flagUrl,
  });

  factory HomeCountryModel.fromMap(Map<String, dynamic> json) {
    return HomeCountryModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      countryCode: (json['country_code'] ?? '').toString(),
      flagUrl: (json['flag_url'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country_code': countryCode,
      'flag_url': flagUrl,
    };
  }

  HomeCountryModel copyWith({
    String? id,
    String? name,
    String? countryCode,
    String? flagUrl,
  }) {
    return HomeCountryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      flagUrl: flagUrl ?? this.flagUrl,
    );
  }
}
