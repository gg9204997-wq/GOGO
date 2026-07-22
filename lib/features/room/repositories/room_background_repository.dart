import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:joojo_chat/features/room/models/room_background_model.dart';

class RoomBackgroundRepository {
  RoomBackgroundRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_backgrounds';

  // جلب كافة الخلفيات التابعة لغرفة معينة
  Future<List<RoomBackgroundModel>> getBackgrounds(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomBackgroundModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب تفاصيل خلفية محددة بواسطة المعرف الخاص بها
  Future<RoomBackgroundModel?> getBackground(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return RoomBackgroundModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إضافة أو رفع خلفية جديدة للغرفة
  Future<String> addBackground(
    RoomBackgroundModel background,
  ) async {
    final data = await _client
        .from(_table)
        .insert(background.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // تحديث بيانات الخلفية بالكامل وتغيير وقت التعديل
  Future<void> update(
    RoomBackgroundModel background,
  ) async {
    await _client
        .from(_table)
        .update(
          background.copyWith(
            updatedAt: DateTime.now(),
          ).toMap(),
        )
        .eq('id', background.id);
  }

  // حذف خلفية معينة من الغرفة نهائياً
  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  // البث الحي لمزامنة الخلفيات داخل الغرفة لحظياً (Real-time Stream)
  Stream<List<RoomBackgroundModel>> streamBackgrounds(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where((e) => e['room_id'] == roomId).toList();

          filtered.sort(
            (a, b) => DateTime.parse(b['created_at'].toString()).compareTo(
              DateTime.parse(a['created_at'].toString()),
            ),
          );

          return filtered.map(RoomBackgroundModel.fromMap).toList();
        });
  }
}
