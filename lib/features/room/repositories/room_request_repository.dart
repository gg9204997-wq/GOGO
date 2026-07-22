import 'package:joojo_chat/features/room/models/room_request_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomRequestRepository {
  RoomRequestRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_requests';

  // جلب كافة طلبات الغرفة (مثل صعود المايك) بناءً على معرف الغرفة والحالة
  Future<List<RoomRequestModel>> getRequests({
    required String roomId,
    String status = 'pending',
  }) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('status', status)
        .order('created_at', ascending: true); // الأقدم أولاً لضمان أولوية التقديم

    return (data as List)
        .map(
          (e) => RoomRequestModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب تفاصيل طلب محدد عبر المعرف الخاص به
  Future<RoomRequestModel?> getRequest(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return RoomRequestModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // تقديم طلب جديد داخل الغرفة (مثل طلب الصعود على المقعد المعين)
  Future<String> create(
    RoomRequestModel request,
  ) async {
    final data = await _client
        .from(_table)
        .insert(request.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // معالجة الطلب (قبول أو رفض) وتحديث بيانات المسؤول ووقت المراجعة
  Future<void> handleRequest({
    required String id,
    required String status,
    required String handledBy,
    String? note,
  }) async {
    await _client
        .from(_table)
        .update({
          'status': status,
          'handled_by': handledBy,
          'note': note,
          'handled_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // سحب أو إلغاء الطلب من طرف المستخدم نفسه (حذف نهائي أو تحديث لحالة ملغى)
  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  // فحص ما إذا كان للمستخدم طلب معلق (pending) حالياً داخل الغرفة لتفادي تكرار الطلبات
  Future<bool> hasPendingRequest({
    required String roomId,
    required String userId,
    required String requestType,
  }) async {
    final data = await _client
        .from(_table)
        .select('id')
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .eq('request_type', requestType)
        .eq('status', 'pending')
        .maybeSingle();

    return data != null;
  }

  // البث الحي واللحظي للطلبات المعلقة داخل الغرفة لكي يراها الـ Admin / Moderator فوراً
  Stream<List<RoomRequestModel>> streamPendingRequests(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where(
            (e) => e['room_id'] == roomId && e['status'] == 'pending',
          ).toList();

          // ترتيب تصاعدي ليعرض أقدم الطلبات أولاً في قائمة الانتظار
          filtered.sort(
            (a, b) => DateTime.parse(a['created_at'].toString()).compareTo(
              DateTime.parse(b['created_at'].toString()),
            ),
          );

          return filtered.map(RoomRequestModel.fromMap).toList();
        });
  }
}
