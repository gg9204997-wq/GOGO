import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// ==========================
  /// إنشاء حساب جديد
  /// ==========================
  Future<bool> registerNewUser({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String gender,
    required String country,
  }) async {
    try {
      // إنشاء حساب Authentication
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw Exception("فشل إنشاء المستخدم.");
      }

      // انتظار بسيط حتى ينتهي Trigger إن وجد
      await Future.delayed(const Duration(milliseconds: 500));

      try {
        // تحديث البيانات إذا كان Trigger أنشأ الصف
        await _supabase.from('profiles').update({
          'name': username,
          'username': username,
          'phone': phone,
          'email': email,
          'gender': gender,
          'country': country,
        }).eq('id', user.id);
      } catch (_) {
        // إذا لم يكن الصف موجوداً
        await _supabase.from('profiles').upsert({
          'id': user.id,
          'name': username,
          'username': username,
          'phone': phone,
          'email': email,
          'gender': gender,
          'country': country,
        });
      }

      // إنشاء المحفظة
      await _supabase.from('wallet').upsert({
        'user_id': user.id,
        'coins': 0,
        'diamonds': 100,
      });

      return true;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// ==========================
  /// تسجيل الدخول بالبريد
  /// ==========================
  Future<bool> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response.user != null;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// ==========================
  /// OTP
  /// ==========================
  Future<void> signInWithPhoneOtp({
    required String phone,
  }) async {
    throw Exception("service_unavailable_phone");
  }

  /// ==========================
  /// Facebook
  /// ==========================
  Future<void> signInWithFacebookOAuth() async {
    throw Exception("service_unavailable_facebook");
  }

  /// ==========================
  /// Google
  /// ==========================
  Future<void> signInWithGoogleOAuth() async {
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.joojovoice://login-callback/',
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception(
        "حدث خطأ أثناء تسجيل الدخول بواسطة Google",
      );
    }
  }

  /// ==========================
  /// Logout
  /// ==========================
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  /// ==========================
  /// المستخدم الحالي
  /// ==========================
  User? get currentUser => _supabase.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  /// ==========================
  /// Profile
  /// ==========================
  Future<Map<String, dynamic>?> fetchProfile() async {
    try {
      final user = currentUser;

      if (user == null) return null;

      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      return data;
    } catch (_) {
      return null;
    }
  }

  /// ==========================
  /// Wallet
  /// ==========================
  Future<Map<String, dynamic>?> fetchWallet() async {
    try {
      final user = currentUser;

      if (user == null) return null;

      final data = await _supabase
          .from('wallet')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

      return data;
    } catch (_) {
      return null;
    }
  }

  /// ==========================
  /// Refresh User
  /// ==========================
  Future<User?> refreshUser() async {
    await _supabase.auth.refreshSession();
    return _supabase.auth.currentUser;
  }
}