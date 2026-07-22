import 'package:joojo_chat/features/room/models/room_notice_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomNoticeRepository {
  RoomNoticeRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_notices';

  // جلب جميع الإعلانات واللوحات الإرشادية الخاصة بغرفة معينة مرتبة بوضع المثبت أولاً ثم الأحدث
  Future<List<RoomNoticeModel>> getNotices(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('is_pinned', ascending: false)
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomNoticeModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب الإعلانات النشطة فقط والتي لم تنتهِ صلاحيتها بعد داخل الغرفة
  Future<List<RoomNoticeModel>> getActiveNotices(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('is_active', true)
        .order('is_pinned', ascending: false)
        .order('created_at', ascending: false);

    final list = (data as List)
        .map(
          (e) => RoomNoticeModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();

    // تصفية الإعلانات البرمجية لاستبعاد المنتهية صلاحيتها زمنياً (Expired)
    return list.where((notice) => !notice.isExpired).toList();
  }

  // جلب تفاصيل إعلان محدد بواسطة المعرف الخاص به
  Future<RoomNoticeModel?> getNotice(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return RoomNoticeModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إنشاء أو نشر إعلان جديد داخل الغرفة
  Future<String> create(
    RoomNoticeModel notice,
  ) async {
    final data = await _client
        .from(_table)
        .insert(notice.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // تحديث بيانات الإعلان بالكامل وتعديل تاريخ التحديث
  Future<void> update(
    RoomNoticeModel notice,
  ) async {
    await _client
        .from(_table)
        .update(
          notice.copyWith(
            updatedAt: DateTime.now(),
          ).toMap(),
        )
        .eq('id', notice.id);
  }

  // تثبيت أو إلغاء تثبيت إعلان معين في أعلى لوحة الغرفة (Pin/Unpin)
  Future<void> togglePin({
    required String id,
    required bool isPinned,
  }) async {
    await _client
        .from(_table)
        .update({
          'is_pinned': isPinned,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // تفعيل أو تجميد ظهور الإعلان (Activate/Deactivate)
  Future<void> toggleActive({
    required String id,
    required bool isActive,
  }) async {
    await _client
        .from(_table)
        .update({
          'is_active': isActive,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // حذف إعلان نهائياً من الجدول
  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  // البث الحي والتحديث الفوري للإعلانات المعروضة داخل الغرفة لمزامنة لوحة الإعلانات (Real-time Stream)
  Stream<List<RoomNoticeModel>> streamNotices(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where((e) => e['room_id'] == roomId).toList();

          // ترتيب منطقي لوضع المثبت أولاً ثم الفرز التنازلي التابع لتاريخ الإنشاء
          filtered.sort((a, b) {
            final aPinned = a['is_pinned'] == true ? 1 : 0;
            final bPinned = b['is_pinned'] == true ? 1 : 0;
            
            if (aPinned != bPinned) {
              return bPinned.compareTo(aPinned);
            }
            
            return DateTime.parse(b['created_at'].toString()).compareTo(
              DateTime.parse(a['created_at'].toString()),
            );
          });

          return filtered
              .map(RoomNoticeModel.fromMap)
              .where((notice) => notice.isActive && !notice.isExpired)
              .toList();
        });
  }
}
