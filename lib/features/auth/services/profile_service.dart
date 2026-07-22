import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  const ProfileService();

  SupabaseClient get _client => Supabase.instance.client;

  static const table = 'profiles';

  //----------------------------------------
  // Get Profile
  //----------------------------------------

  Future<Map<String, dynamic>?> getProfile(
    String userId,
  ) async {
    return await _client
        .from(table)
        .select()
        .eq('user_id', userId)
        .maybeSingle();
  }

  //----------------------------------------
  // Create Profile
  //----------------------------------------

  Future<void> createProfile({
    required String userId,
    required String name,
    required String email,
    required String username,
    String? phone,
  }) async {
    final exists = await getProfile(userId);

    if (exists != null) return;

    await _client.from(table).insert({
      'user_id': userId,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,

      'avatar': '',
      'cover': '',
      'bio': '',

      'gender': null,
      'birthday': null,

      'country': '',
      'city': '',
      'language': 'ar',

      'level': 1,
      'xp': 0,

      'coins': 0,
      'diamonds': 0,

      'vip_level': 0,

      'followers': 0,
      'following': 0,
      'visitors': 0,

      'verified': false,
      'profile_completed': false,

      'online': true,
      'is_host': false,
      'is_admin': false,
      'is_banned': false,

      'created_at': DateTime.now().toIso8601String(),
    });
  }

  //----------------------------------------
  // Update
  //----------------------------------------

  Future<void> updateProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await _client
        .from(table)
        .update(data)
        .eq('user_id', userId);
  }

  //----------------------------------------
  // Avatar
  //----------------------------------------

  Future<void> updateAvatar({
    required String userId,
    required String avatar,
  }) async {
    await updateProfile(
      userId: userId,
      data: {
        'avatar': avatar,
      },
    );
  }

  //----------------------------------------
  // Cover
  //----------------------------------------

  Future<void> updateCover({
    required String userId,
    required String cover,
  }) async {
    await updateProfile(
      userId: userId,
      data: {
        'cover': cover,
      },
    );
  }

  //----------------------------------------
  // Online
  //----------------------------------------

  Future<void> updateOnline({
    required String userId,
    required bool online,
  }) async {
    await updateProfile(
      userId: userId,
      data: {
        'online': online,
        'last_seen': DateTime.now().toIso8601String(),
      },
    );
  }

  //----------------------------------------
  // Delete
  //----------------------------------------

  Future<void> deleteProfile(
    String userId,
  ) async {
    await _client
        .from(table)
        .delete()
        .eq('user_id', userId);
  }
}