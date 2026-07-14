import 'package:flutter/foundation.dart';

@immutable
class RegisterRequest {
  const RegisterRequest({
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.avatarUrl,
    this.bio,
    this.countryName,
    this.city,
    this.gender,
    this.dateOfBirth,
  });

  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String? avatarUrl;
  final String? bio;
  final String? countryName;
  final String? city;
  final String? gender;
  final DateTime? dateOfBirth;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'avatar_url': avatarUrl,
      'bio': bio,
      'country_name': countryName,
      'city': city,
      'gender': gender,
      'date_of_birth': dateOfBirth?.toIso8601String(),
    };
  }

  RegisterRequest copyWith({
    String? username,
    String? fullName,
    String? email,
    String? phone,
    String? password,
    String? avatarUrl,
    String? bio,
    String? countryName,
    String? city,
    String? gender,
    DateTime? dateOfBirth,
  }) {
    return RegisterRequest(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      countryName: countryName ?? this.countryName,
      city: city ?? this.city,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
