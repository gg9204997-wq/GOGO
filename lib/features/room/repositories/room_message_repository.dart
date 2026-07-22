import 'package:joojo_chat/features/room/models/room_message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomMessageRepository {
  RoomMessageRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_messages';

  // جلب رسائل الغرفة مع تحديد الحد الأقصى والترتيب الزمني
  Future<List<RoomMessageModel>> getMessages(
    String roomId, {
    int limit = 100,
  }) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('is_deleted', false)
        .order('created_at')
        .limit(limit);

    return (data as List)
        .map(
          (e) => RoomMessageModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب تفاصيل رسالة محددة عبر المعرف الخاص بها
  Future<RoomMessageModel?> getMessage(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return RoomMessageModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إرسال رسالة جديدة وإرجاع المعرف الخاص بها بعد الإدخال
  Future<String> send(
    RoomMessageModel message,
  ) async {
    final data = await _client
        .from(_table)
        .insert(message.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // تحديث كائن الرسالة بالكامل ووسمها كرسالة معدلة
  Future<void> update(
    RoomMessageModel message,
  ) async {
    await _client
        .from(_table)
        .update(
          message.copyWith(
            edited: true,
            updatedAt: DateTime.now(),
          ).toMap(),
        )
        .eq('id', message.id);
  }

  // حذف رسالة منطقياً عبر تغيير حالة الحذف وتحديث وقت التعديل
  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .update({
          'is_deleted': true,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // تعديل نص الرسالة مباشرة وتحديث وقت التعديل
  Future<void> edit({
    required String id,
    required String message,
  }) async {
    await _client
        .from(_table)
        .update({
          'message': message,
          'edited': true,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // ترجمة نص الرسالة وتحديث الحقول المخصصة للغة والترجمة
  Future<void> translate({
    required String id,
    required String language,
    required String message,
  }) async {
    await _client
        .from(_table)
        .update({
          'message': message,
          'language': language,
          'translated': true,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // استعادة الرسالة المحذوفة منطقياً
  Future<void> restore(
    String id,
  ) async {
    await _client
        .from(_table)
        .update({
          'is_deleted': false,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // جلب الرسائل الخاصة بمستخدم معين داخل غرفة محددة
  Future<List<RoomMessageModel>> getUserMessages({
    required String roomId,
    required String userId,
  }) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('sender', userId)
        .eq('is_deleted', false)
        .order('created_at');

    return (data as List)
        .map(
          (e) => RoomMessageModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب رسائل النظام فقط داخل غرفة معينة
  Future<List<RoomMessageModel>> getSystemMessages(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('is_system', true)
        .order('created_at');

    return (data as List)
        .map(
          (e) => RoomMessageModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // حساب عدد الرسائل غير المحذوفة داخل غرفة معينة
  Future<int> count(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select('id')
        .eq('room_id', roomId)
        .eq('is_deleted', false);

    return (data as List).length;
  }

  // التحقق من وجود رسالة معينة في قاعدة البيانات عبر معرفها
  Future<bool> exists(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select('id')
        .eq('id', id)
        .maybeSingle();

    return data != null;
  }

  // البث الحي والمستمر لرسائل الغرفة غير المحذوفة مرتبة زمنياً
  Stream<List<RoomMessageModel>> streamMessages(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where(
            (e) =>
                e['room_id'] == roomId &&
                (e['is_deleted'] ?? false) == false,
          ).toList();

          filtered.sort(
            (a, b) => DateTime.parse(
              a['created_at'].toString(),
            ).compareTo(
              DateTime.parse(
                b['created_at'].toString(),
              ),
            ),
          );

          return filtered
              .map(RoomMessageModel.fromMap)
              .toList();
        });
  }

  // البث الحي لتحديثات رسالة واحدة محددة
  Stream<RoomMessageModel?> streamMessage(
    String id,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where(
            (e) => e['id'] == id,
          );

          if (filtered.isEmpty) {
            return null;
          }

          return RoomMessageModel.fromMap(
            filtered.first,
          );
        });
  }
}
