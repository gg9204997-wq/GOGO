import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/auth/models/profile_model.dart';
import 'package:joojo_chat/features/auth/repository/auth_repository.dart';

/// Repository
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => const AuthRepository(),
);

/// Current User
final currentUserProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserProfileModel?>>(
  (ref) {
    return AuthNotifier(
      ref.read(authRepositoryProvider),
    );
  },
);

class AuthNotifier extends StateNotifier<AsyncValue<UserProfileModel?>> {
  AuthNotifier(this._repository)
      : super(const AsyncData(null));

  final AuthRepository _repository;

  //------------------------------------------------
  // Login
  //------------------------------------------------

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    try {
      final user = await _repository.signIn(
        email: email,
        password: password,
      );

      state = AsyncData(user);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  //------------------------------------------------
  // Register
  //------------------------------------------------

  Future<void> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    String? phone,
  }) async {
    state = const AsyncLoading();

    try {
      final user = await _repository.signUp(
        name: name,
        username: username,
        email: email,
        password: password,
        phone: phone,
      );

      state = AsyncData(user);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  //------------------------------------------------
  // Google
  //------------------------------------------------

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();

    try {
      await _repository.signInWithGoogle();
      await loadCurrentUser();
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  //------------------------------------------------
  // Facebook
  //------------------------------------------------

  Future<void> signInWithFacebook() async {
    state = const AsyncLoading();

    try {
      await _repository.signInWithFacebook();
      await loadCurrentUser();
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  //------------------------------------------------
  // Current User
  //------------------------------------------------

  Future<void> loadCurrentUser() async {
    try {
      final user = await _repository.getCurrentProfile();
      state = AsyncData(user);
    } catch (_) {
      state = const AsyncData(null);
    }
  }

  //------------------------------------------------
  // Logout
  //------------------------------------------------

  Future<void> signOut() async {
    await _repository.signOut();
    state = const AsyncData(null);
  }

  //------------------------------------------------
  // Update Profile
  //------------------------------------------------

  Future<void> updateProfile(
    Map<String, dynamic> data,
  ) async {
    await _repository.updateProfile(
      data: data,
    );

    await loadCurrentUser();
  }

  //------------------------------------------------
  // Avatar
  //------------------------------------------------

  Future<void> updateAvatar(
    String avatar,
  ) async {
    await _repository.updateAvatar(
      avatar,
    );

    await loadCurrentUser();
  }

  //------------------------------------------------
  // Cover
  //------------------------------------------------

  Future<void> updateCover(
    String cover,
  ) async {
    await _repository.updateCover(
      cover,
    );

    await loadCurrentUser();
  }

  //------------------------------------------------
  // Phone
  //------------------------------------------------

  Future<void> updatePhone(
    String phone,
  ) async {
    await _repository.updatePhone(
      phone,
    );

    await loadCurrentUser();
  }

  //------------------------------------------------
  // Password
  //------------------------------------------------

  Future<void> resetPassword(
    String email,
  ) async {
    await _repository.resetPassword(email);
  }

  Future<void> updatePassword(
    String password,
  ) async {
    await _repository.updatePassword(password);
  }

  Future<void> updateEmail(
    String email,
  ) async {
    await _repository.updateEmail(email);
  }
}