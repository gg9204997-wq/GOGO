import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile_model.dart';
import '../services/auth_service.dart';
import '../services/phone_auth_service.dart';
import '../services/profile_service.dart';

class AuthRepository {
  const AuthRepository();

  final AuthService _auth = const AuthService();
  final ProfileService _profile = const ProfileService();
  final PhoneAuthService _phone = const PhoneAuthService();

  User? get currentUser => _auth.currentUser;

  bool get isLoggedIn => _auth.isLoggedIn;

  Stream<AuthState> get authState => _auth.authState;

  //----------------------------------------------------
  // Login
  //----------------------------------------------------

  Future<UserProfileModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _auth.signIn(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('فشل تسجيل الدخول');
    }

    final profile = await _profile.getProfile(user.id);

    if (profile == null) {
      throw Exception('Profile not found');
    }

    return UserProfileModel.fromMap(profile);
  }

  //----------------------------------------------------
  // Register
  //----------------------------------------------------

  Future<UserProfileModel> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    String? phone,
  }) async {
    final response = await _auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
      },
    );

    final user = response.user;

    if (user == null) {
      throw Exception('فشل إنشاء الحساب');
    }

    await _profile.createProfile(
      userId: user.id,
      name: name,
      email: email,
      username: username,
      phone: phone,
    );

    final profile = await _profile.getProfile(user.id);

    if (profile == null) {
      throw Exception('Profile not created');
    }

    return UserProfileModel.fromMap(profile);
  }

  //----------------------------------------------------
  // Google
  //----------------------------------------------------

  Future<void> signInWithGoogle() async {
    await _auth.signInWithGoogle();
  }

  //----------------------------------------------------
  // Facebook
  //----------------------------------------------------

  Future<void> signInWithFacebook() async {
    await _auth.signInWithFacebook();
  }

  //----------------------------------------------------
  // Phone OTP
  //----------------------------------------------------

  Future<void> sendPhoneOtp(
    String phone,
  ) async {
    await _phone.sendOtp(phone);
  }

  Future<void> resendPhoneOtp(
    String phone,
  ) async {
    await _phone.resendOtp(phone);
  }

  Future<UserProfileModel> verifyPhoneOtp({
    required String phone,
    required String token,
  }) async {
    final response = await _phone.verifyOtp(
      phone: phone,
      token: token,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('فشل التحقق من الرمز');
    }

    var profile = await _profile.getProfile(user.id);

    if (profile == null) {
      await _profile.createProfile(
        userId: user.id,
        name: '',
        email: '',
        username:
            'user_${DateTime.now().millisecondsSinceEpoch}',
        phone: phone,
      );

      profile = await _profile.getProfile(user.id);
    }

    return UserProfileModel.fromMap(profile!);
  }  //----------------------------------------------------
  // Logout
  //----------------------------------------------------

  Future<void> signOut() async {
    final user = currentUser;

    if (user != null) {
      await _profile.updateOnline(
        userId: user.id,
        online: false,
      );
    }

    await _auth.signOut();
  }

  //----------------------------------------------------
  // Password
  //----------------------------------------------------

  Future<void> resetPassword(
    String email,
  ) async {
    await _auth.resetPassword(email);
  }

  Future<void> updatePassword(
    String password,
  ) async {
    await _auth.updatePassword(password);
  }

  Future<void> updateEmail(
    String email,
  ) async {
    await _auth.updateEmail(email);
  }

  Future<void> resendConfirmationEmail(
    String email,
  ) async {
    await _auth.resendConfirmationEmail(
      email,
    );
  }

  Future<void> verifyEmailOtp({
    required String email,
    required String token,
  }) async {
    await _auth.verifyOtp(
      email: email,
      token: token,
      type: OtpType.email,
    );
  }

  //----------------------------------------------------
  // Current Profile
  //----------------------------------------------------

  Future<UserProfileModel> getCurrentProfile() async {
    final user = currentUser;

    if (user == null) {
      throw Exception(
        'No authenticated user',
      );
    }

    final profile = await _profile.getProfile(
      user.id,
    );

    if (profile == null) {
      throw Exception(
        'Profile not found',
      );
    }

    return UserProfileModel.fromMap(profile);
  }

  //----------------------------------------------------
  // Update Profile
  //----------------------------------------------------

  Future<void> updateProfile({
    required Map<String, dynamic> data,
  }) async {
    final user = currentUser;

    if (user == null) {
      throw Exception(
        'No authenticated user',
      );
    }

    await _profile.updateProfile(
      userId: user.id,
      data: data,
    );
  }

  //----------------------------------------------------
  // Avatar
  //----------------------------------------------------

  Future<void> updateAvatar(
    String avatar,
  ) async {
    final user = currentUser;

    if (user == null) {
      throw Exception(
        'No authenticated user',
      );
    }

    await _profile.updateAvatar(
      userId: user.id,
      avatar: avatar,
    );
  }

  //----------------------------------------------------
  // Cover
  //----------------------------------------------------

  Future<void> updateCover(
    String cover,
  ) async {
    final user = currentUser;

    if (user == null) {
      throw Exception(
        'No authenticated user',
      );
    }

    await _profile.updateCover(
      userId: user.id,
      cover: cover,
    );
  }

  //----------------------------------------------------
  // Phone
  //----------------------------------------------------

  Future<void> updatePhone(
    String phone,
  ) async {
    final user = currentUser;

    if (user == null) {
      throw Exception(
        'No authenticated user',
      );
    }

    await _profile.updateProfile(
      userId: user.id,
      data: {
        'phone': phone,
      },
    );
  }

  //----------------------------------------------------
  // Exists
  //----------------------------------------------------

  Future<bool> phoneExists(
    String phone,
  ) async {
    final result =
        await Supabase.instance.client
            .from('profiles')
            .select('user_id')
            .eq('phone', phone)
            .maybeSingle();

    return result != null;
  }

  Future<bool> emailExists(
    String email,
  ) async {
    final result =
        await Supabase.instance.client
            .from('profiles')
            .select('user_id')
            .eq('email', email)
            .maybeSingle();

    return result != null;
  }

  Future<bool> usernameExists(
    String username,
  ) async {
    final result =
        await Supabase.instance.client
            .from('profiles')
            .select('user_id')
            .eq('username', username)
            .maybeSingle();

    return result != null;
  }
}