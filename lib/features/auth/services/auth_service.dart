import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  const AuthService();

  SupabaseClient get _client => Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  Stream<AuthState> get authState => _client.auth.onAuthStateChange;

  //------------------------------------
  // Login
  //------------------------------------

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //------------------------------------
  // Register
  //------------------------------------

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
  }

  //------------------------------------
  // Logout
  //------------------------------------

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  //------------------------------------
  // Reset Password
  //------------------------------------

  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  //------------------------------------
  // Update Password
  //------------------------------------

  Future<UserResponse> updatePassword(
    String password,
  ) async {
    return await _client.auth.updateUser(
      UserAttributes(password: password),
    );
  }

  //------------------------------------
  // Update Email
  //------------------------------------

  Future<UserResponse> updateEmail(
    String email,
  ) async {
    return await _client.auth.updateUser(
      UserAttributes(email: email),
    );
  }

  //------------------------------------
  // Verify OTP
  //------------------------------------

  Future<AuthResponse> verifyOtp({
    required String email,
    required String token,
    OtpType type = OtpType.email,
  }) async {
    return await _client.auth.verifyOTP(
      email: email,
      token: token,
      type: type,
    );
  }

  //------------------------------------
  // Resend Email
  //------------------------------------

  Future<void> resendConfirmationEmail(
    String email,
  ) async {
    await _client.auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }

  //------------------------------------
  // Google
  //------------------------------------

  Future<bool> signInWithGoogle() async {
    return await _client.auth.signInWithOAuth(
      OAuthProvider.google,
    );
  }

  //------------------------------------
  // Facebook
  //------------------------------------

  Future<bool> signInWithFacebook() async {
    return await _client.auth.signInWithOAuth(
      OAuthProvider.facebook,
    );
  }
}