import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(
    ref.read(authRepositoryProvider),
  );
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository _repository;

  AuthNotifier(this._repository)
      : super(AsyncData(_repository.currentUser));

  User? get currentUser => _repository.currentUser;

  bool get isLoggedIn => _repository.isLoggedIn;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      state = const AsyncLoading();

      final response = await _repository.login(
        email: email,
        password: password,
      );

      state = AsyncData(response.user);

      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required Map<String, dynamic> data,
  }) async {
    try {
      state = const AsyncLoading();

      final response = await _repository.register(
        email: email,
        password: password,
        data: data,
      );

      state = AsyncData(response.user);

      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refreshSession() async {
    try {
      final response = await _repository.refreshSession();
      state = AsyncData(response.user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}