import 'dart:io';

import 'package:joojo_chat/core/services/supabase_service.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  const StorageService();

  SupabaseStorageClient get _storage =>
      SupabaseService.storage;

  /// رفع ملف وإرجاع الرابط العام
  Future<String> uploadImage({
    required String bucket,
    required File file,
    required String folder,
    required String fileName,
  }) async {
    final extension = path.extension(file.path);

    final storagePath =
        '$folder/$fileName$extension';

    await _storage.from(bucket).upload(
          storagePath,
          file,
          fileOptions: const FileOptions(
            upsert: true,
          ),
        );

    return _storage
        .from(bucket)
        .getPublicUrl(storagePath);
  }

  /// حذف ملف
  Future<void> deleteImage({
    required String bucket,
    required String storagePath,
  }) async {
    await _storage
        .from(bucket)
        .remove([storagePath]);
  }

  /// الحصول على الرابط العام
  String getPublicUrl({
    required String bucket,
    required String storagePath,
  }) {
    return _storage
        .from(bucket)
        .getPublicUrl(storagePath);
  }
}