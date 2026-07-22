// Path: lib/core/providers/background_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// هذا الـ Provider يستمع لقاعدة البيانات بشكل حي ومباشر
final appBackgroundProvider = StreamProvider<bool>((ref) {
  final supabase = Supabase.instance.client;

  // الاستماع لجدول app_settings فور حدوث أي تعديل به
  return supabase
      .from('app_settings')
      .stream(primaryKey: ['id'])
      .map((maps) {
        if (maps.isNotEmpty) {
          // جلب قيمة المتغير (هل الخلفية متحركة أم لا)
          return maps.first['is_animated_bg'] as bool? ?? false;
        }
        return false;
      });
});
