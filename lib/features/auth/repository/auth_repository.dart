import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';

class AuthRepository {
  User? get currentUser => AuthService.currentUser;

  bool get isLoggedIn => AuthService.isLoggedIn;

  Stream<AuthState> authState() {
    return AuthService.authStateChanges;
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) {
    return AuthService.signIn(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> register({
    required String email,
    required String password,
    required Map<String, dynamic> data,
  }) {
    return AuthService.signUp(
      email: email,
      password: password,
      data: data,
    );
  }

  Future<void> logout() {
    return AuthService.signOut();
  }

  Future<void> resetPassword({
    required String email,
  }) {
    return AuthService.resetPassword(
      email: email,
    );
  }

  Future<AuthResponse> refreshSession() {
    return AuthService.refreshSession();
  }
}