import 'dart:io';

import 'package:joojo_chat/core/storage/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  ProfileRepository({
    required StorageService storageService,
  }) : _storage = storageService;

  final StorageService _storage;

  final SupabaseClient _client = Supabase.instance.client;

  Future<void> completeProfile({
    required String userId,
    required String country, required DateTime birthday, required String gender, required String bio, File? avatarFile,
  }) async {
    String? avatarUrl;

    if (avatarFile != null) {
      avatarUrl = await _storage.uploadAvatar(
        userId: userId,
        image: avatarFile,
      );
    }

    await _client
        .from('profiles')
        .update({
          'avatar': ?avatarUrl,

          'country': country,
          'birthday': birthday.toIso8601String(),
          'gender': gender,
          'bio': bio,

          'profile_completed': true,

          'updated_at':
              DateTime.now().toIso8601String(),
        })
        .eq('id', userId);

    if (avatarUrl != null) {
      await _client
          .from('users')
          .update({
            'avatar_url': avatarUrl,
          })
          .eq('id', userId);
    }
  }

  Future<void> updateOnlineStatus({
    required String userId,
    required bool online,
  }) async {
    await _client
        .from('profiles')
        .update({
          'online': online,
          'status': online
              ? 'online'
              : 'offline',
          'last_seen':
              DateTime.now().toIso8601String(),
        })
        .eq('id', userId);
  }

  Future<void> updateBio({
    required String userId,
    required String bio,
  }) async {
    await _client
        .from('profiles')
        .update({
          'bio': bio,
          'updated_at':
              DateTime.now().toIso8601String(),
        })
        .eq('id', userId);
  }

  Future<void> updateCountry({
    required String userId,
    required String country,
  }) async {
    await _client
        .from('profiles')
        .update({
          'country': country,
          'updated_at':
              DateTime.now().toIso8601String(),
        })
        .eq('id', userId);
  }

  Future<void> updateAvatar({
    required String userId,
    required File image,
  }) async {
    final avatarUrl =
        await _storage.uploadAvatar(
      userId: userId,
      image: image,
    );

    await _client
        .from('profiles')
        .update({
          'avatar': avatarUrl,
          'updated_at':
              DateTime.now().toIso8601String(),
        })
        .eq('id', userId);

    await _client
        .from('users')
        .update({
          'avatar_url': avatarUrl,
        })
        .eq('id', userId);
  }
}