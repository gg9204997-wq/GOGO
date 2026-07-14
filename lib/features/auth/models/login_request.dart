import 'package:flutter/foundation.dart';

@immutable
class LoginRequest {
  const LoginRequest({
    required this.identifier,
    required this.password,
  });

  final String identifier;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'password': password,
    };
  }

  LoginRequest copyWith({
    String? identifier,
    String? password,
  }) {
    return LoginRequest(
      identifier: identifier ?? this.identifier,
      password: password ?? this.password,
    );
  }
}
