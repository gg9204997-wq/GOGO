import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  final SupabaseClient _client = Supabase.instance.client;

  /// اسم Bucket
  static const String avatarBucket = 'avatars';

  /// رفع صورة المستخدم
  Future<String> uploadAvatar({
    required String userId,
    required File image,
  }) async {
    final extension = path.extension(image.path);

    final fileName =
        '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}$extension';

    await _client.storage
        .from(avatarBucket)
        .upload(
          fileName,
          image,
          fileOptions: const FileOptions(
            upsert: true,
          ),
        );

    return _client.storage
        .from(avatarBucket)
        .getPublicUrl(fileName);
  }

  /// حذف صورة
  Future<void> deleteAvatar(String filePath) async {
    await _client.storage
        .from(avatarBucket)
        .remove([
      filePath,
    ]);
  }
}