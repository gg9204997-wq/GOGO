import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepositoryInterface {
  Future<bool> registerNewUser({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String gender,
    required String country,
  });

  Future<bool> loginWithEmail({
    required String email,
    required String password,
  });

  Future<void> signInWithPhoneOtp({
    required String phone,
  });

  Future<void> signInWithFacebookOAuth();

  Future<void> signInWithGoogleOAuth();

  Future<void> logout();

  User? get currentUser;

  bool get isLoggedIn;

  Future<Map<String, dynamic>?> fetchProfile();

  Future<Map<String, dynamic>?> fetchWallet();

  Future<User?> refreshUser();

  Future<void> resetPassword({
    required String email,
  });
}
