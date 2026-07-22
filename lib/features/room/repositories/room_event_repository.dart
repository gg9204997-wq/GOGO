import 'package:joojo_chat/features/room/models/room_event_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomEventRepository {
  RoomEventRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_events';

  // جلب كل الفعاليات داخل غرفة معينة
  Future<List<RoomEventModel>> getEvents(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomEventModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب الفعاليات النشطة فقط داخل الغرفة
  Future<List<RoomEventModel>> getActiveEvents(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('status', 'active')
        .order('start_time', ascending: true);

    return (data as List)
        .map(
          (e) => RoomEventModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب تفاصيل فعالية محددة بواسطة المعرف الخاص بها
  Future<RoomEventModel?> getEvent(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return RoomEventModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إنشاء فعالية جديدة في الغرفة
  Future<String> create(
    RoomEventModel event,
  ) async {
    final data = await _client
        .from(_table)
        .insert(event.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // تحديث بيانات الفعالية بالكامل
  Future<void> update(
    RoomEventModel event,
  ) async {
    await _client
        .from(_table)
        .update(
          event.copyWith(
            updatedAt: DateTime.now(),
          ).toMap(),
        )
        .eq('id', event.id);
  }

  // تحديث حالة الفعالية (مثل: cancelled, completed, active)
  Future<void> updateStatus({
    required String id,
    required String status,
  }) async {
    await _client
        .from(_table)
        .update({
          'status': status,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // حذف فعالية نهائياً من الجدول
  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  // جلب الفعاليات التي تقع في مجال زمني محدد
  Future<List<RoomEventModel>> getEventsInPeriod({
    required String roomId,
    required DateTime start,
    required DateTime end,
  }) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .gte('start_time', start.toIso8601String())
        .lte('end_time', end.toIso8601String())
        .order('start_time');

    return (data as List)
        .map(
          (e) => RoomEventModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // البث الحي للفعاليات داخل غرفة معينة (Real-time Stream)
  Stream<List<RoomEventModel>> streamEvents(
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

          return filtered.map(RoomEventModel.fromMap).toList();
        });
  }
}
