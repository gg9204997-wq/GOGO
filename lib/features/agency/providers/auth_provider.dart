// Path: lib/features/agency/providers/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joojo_chat/features/profile/models/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// 1. مزود العميل الأساسي لـ Supabase للوصول إلى دالة الـ auth المباشرة بالسيرفر
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// 2. حالة إدارة الهوية والـ Auth المكتملة والمصفاة بالملي
@immutable
class AuthState {
  final User? user; 
  final UserProfileModel? profile; 
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const AuthState({
    this.user,
    this.profile,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  AuthState copyWith({
    User? user,
    UserProfileModel? profile,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AuthState(
      user: user ?? this.user,
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// 3. مزود إدارة الحالة الكبرى (NotifierProvider) لاستدعائه داخل الشاشات حياً
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return AuthNotifier(supabase);
});

// 4. كلاس التحكم بجميع عمليات الهوية والتسجيل الحية بالسيرفر
class AuthNotifier extends StateNotifier<AuthState> {
  final SupabaseClient _supabase;

  AuthNotifier(this._supabase) : super(const AuthState()) {
    // الاستماع الفوري لتغيرات الجلسة وتحديث حالة الهوية والملف الشخصي تلقائياً بالخلفية
    _supabase.auth.onAuthStateChange.listen((data) async {
      final currentUser = data.session?.user;
      if (currentUser != null) {
        final profileData = await _fetchUserProfile(currentUser.id);
        state = AuthState(user: currentUser, profile: profileData, isSuccess: true);
      } else {
        state = const AuthState();
      }
    });
  }

  /// 🌐 دالة جلب كافة الحقول الـ 37 للمستخدم من جدول profiles بالسيرفر حياً
  Future<UserProfileModel?> _fetchUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('user_id', userId)
          .maybeSingle();
      
      if (response != null) {
        return UserProfileModel.fromMap(response);
      }
    } catch (_) {
      // حماية المنصة في حال لم ينشأ جدول البيانات الشخصية بعد
    }
    return null;
  }

  /// 🔐 1. دالة تسجيل الدخول التقليدية بالبريد الإلكتروني وكلمة المرور
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final profileData = await _fetchUserProfile(response.user!.id);
      state = AuthState(user: response.user, profile: profileData, isSuccess: true);
    } on AuthException catch (e) {
      state = AuthState(errorMessage: e.message);
    } catch (e) {
      state = const AuthState(errorMessage: 'حدث خطأ غير متوقع أثناء تسجيل الدخول');
    }
  }

  /// 📝 2. دالة إنشاء حساب جديد مطورة ومربوطة بكامل البيانات الحيوية لجدول الـ Profiles
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String gender,
    required String birthday,
    required String country,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'username': email.split('@').first, 
          'phone': phone,
          'gender': gender,
          'birthday': birthday,
          'country': country,
          'level': 1, 
          'profile_completed': false,
        },
      );
      final profileData = await _fetchUserProfile(response.user!.id);
      state = AuthState(user: response.user, profile: profileData, isSuccess: true);
    } on AuthException catch (e) {
      state = AuthState(errorMessage: e.message);
    } catch (e) {
      state = const AuthState(errorMessage: 'حدث خطأ غير متوقع أثناء إنشاء الحساب');
    }
  }

  /// 📱 3. دالة إرسال رمز التحقق الـ OTP إلى رقم هاتف المستخدم
  Future<void> sendOtpToPhone({required String phoneNumber}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _supabase.auth.signInWithOtp(
        phone: phoneNumber,
      );
      state = const AuthState(isSuccess: true);
    } on AuthException catch (e) {
      state = AuthState(errorMessage: e.message);
    } catch (e) {
      state = const AuthState(errorMessage: 'حدث خطأ أثناء إرسال رمز التفعيل');
    }
  }

  /// 🔢 4. دالة التحقق وتأكيد كود الـ OTP لولوج التطبيق حياً
  Future<void> verifyOtpCode({
    required String phoneNumber,
    required String token,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await _supabase.auth.verifyOTP(
        phone: phoneNumber,
        token: token,
        type: OtpType.sms,
      );
      final profileData = await _fetchUserProfile(response.user!.id);
      state = AuthState(user: response.user, profile: profileData, isSuccess: true);
    } on AuthException catch (e) {
      state = AuthState(errorMessage: e.message);
    } catch (e) {
      state = const AuthState(errorMessage: 'رمز التحقق غير صحيح، يرجى إعادة المحاولة');
    }
  }

  /// 🔐 5. دالة تحديث وإعادة تعيين كلمة المرور الجديدة حياً داخل السيرفر
  Future<void> updateNewPassword({required String newPassword}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      state = const AuthState(isSuccess: true);
    } on AuthException catch (e) {
      state = AuthState(errorMessage: e.message);
    } catch (e) {
      state = const AuthState(errorMessage: 'حدث خطأ أثناء تحديث كلمة المرور');
    }
  }

  /// 🚪 6. دالة تسجيل الخروج من المنصة وتدمير الجلسة الحالية حياً
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await _supabase.auth.signOut();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
