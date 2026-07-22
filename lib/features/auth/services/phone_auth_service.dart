import 'package:supabase_flutter/supabase_flutter.dart';

class PhoneAuthService {
  const PhoneAuthService();

  SupabaseClient get _client => Supabase.instance.client;

  //----------------------------------------
  // إرسال OTP
  //----------------------------------------

  Future<void> sendOtp(String phone) async {
    await _client.auth.signInWithOtp(
      phone: phone,
    );
  }

  //----------------------------------------
  // إعادة إرسال OTP
  //----------------------------------------

  Future<void> resendOtp(String phone) async {
    await _client.auth.signInWithOtp(
      phone: phone,
    );
  }

  //----------------------------------------
  // التحقق من OTP
  //----------------------------------------

  Future<AuthResponse> verifyOtp({
    required String phone,
    required String token,
  }) async {
    return await _client.auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms,
    );
  }
}