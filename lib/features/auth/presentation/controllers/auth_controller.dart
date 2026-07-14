import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/auth/data/repositories/auth_repository.dart';
import 'package:joojo_chat/features/auth/domain/usecases/login_usecase.dart';
import 'package:joojo_chat/features/auth/domain/usecases/register_usecase.dart';
import 'package:joojo_chat/features/auth/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.read(authRepositoryProvider));
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserModel?>>((ref) {
  return AuthController(
    ref.read(authRepositoryProvider),
    ref.read(loginUseCaseProvider),
    ref.read(registerUseCaseProvider),
  );
});

class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  AuthController(
    this._repository,
    this._loginUseCase,
    this._registerUseCase,
  ) : super(const AsyncValue.data(null));

  final AuthRepository _repository;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  bool get isLoading => state.isLoading;

  Future<void> checkSession() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _repository.fetchProfile();
      if (user != null) {
        return UserModel.fromJson(user);
      }
      return null;
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final success = await _loginUseCase(
        email: email,
        password: password,
      );
      if (success) {
        final profile = await _repository.fetchProfile();
        if (profile != null) {
          return UserModel.fromJson(profile);
        }
      }
      return null;
    });
  }

  Future<void> register({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String gender,
    required String country,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final success = await _registerUseCase(
        username: username,
        phone: phone,
        email: email,
        password: password,
        gender: gender,
        country: country,
      );
      if (success) {
        final profile = await _repository.fetchProfile();
        if (profile != null) {
          return UserModel.fromJson(profile);
        }
      }
      return null;
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.logout();
      return null;
    });
  }

  Future<void> refreshUser() async {
    final user = await _repository.refreshUser();
    if (user != null) {
      final profile = await _repository.fetchProfile();
      if (profile != null) {
        state = AsyncValue.data(UserModel.fromJson(profile));
      }
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signInWithGoogleOAuth();
      final profile = await _repository.fetchProfile();
      if (profile != null) {
        return UserModel.fromJson(profile);
      }
      return null;
    });
  }

  Future<void> loginWithFacebook() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signInWithFacebookOAuth();
      final profile = await _repository.fetchProfile();
      if (profile != null) {
        return UserModel.fromJson(profile);
      }
      return null;
    });
  }

  Future<void> loginWithPhone({
    required String phone,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signInWithPhoneOtp(phone: phone);
      final profile = await _repository.fetchProfile();
      if (profile != null) {
        return UserModel.fromJson(profile);
      }
      return null;
    });
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.resetPassword(email: email);
      return null;
    });
  }
}
