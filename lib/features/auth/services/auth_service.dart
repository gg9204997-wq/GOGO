import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final SupabaseClient client = Supabase.instance.client;

  static GoTrueClient get auth => client.auth;

  static User? get currentUser => auth.currentUser;

  static bool get isLoggedIn => currentUser != null;

  static Stream<AuthState> get authStateChanges =>
      auth.onAuthStateChange;

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) {
    return auth.signUp(
      email: email,
      password: password,
      data: data,
    );
  }

  static Future<void> signOut() {
    return auth.signOut();
  }

  static Future<void> resetPassword({
    required String email,
  }) {
    return auth.resetPasswordForEmail(email);
  }

  static Future<AuthResponse> refreshSession() {
    return auth.refreshSession();
  }
}