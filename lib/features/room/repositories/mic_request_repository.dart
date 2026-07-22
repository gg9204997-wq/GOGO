import 'package:joojo_chat/features/room/models/mic_request_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MicRequestRepository {
  MicRequestRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'mic_requests';

  // جلب كافة طلبات المايك المعلقة في الغرفة مرتبة بالأقدم لضمان أولوية التقديم الأسبق
  Future<List<MicRequestModel>> getPendingRequests(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('status', 'pending')
        .order('created_at', ascending: true);

    return (data as List)
        .map(
          (e) => MicRequestModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب تفاصيل طلب مايك محدد عبر المعرف الخاص به
  Future<MicRequestModel?> getRequest(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return MicRequestModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // تقديم طلب صعود للمايك جديد (يبدأ بحالة pending افتراضياً)
  Future<String> create(
    MicRequestModel request,
  ) async {
    final data = await _client
        .from(_table)
        .insert(request.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // معالجة طلب المايك (قبول أو رفض) وتحديد المشرف المسؤول ووقت المراجعة
  Future<void> handleRequest({
    required String id,
    required String status,
    required String handledBy,
  }) async {
    await _client
        .from(_table)
        .update({
          'status': status,
          'handled_by': handledBy,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // سحب طلب المايك أو إلغاؤه نهائياً من قِبل المستخدم نفسه
  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  // التحقق من وجود طلب مايك معلق للمستخدم حالياً لتفادي تكرار طلبات الصعود
  Future<bool> hasPendingRequest({
    required String roomId,
    required String userId,
  }) async {
    final data = await _client
        .from(_table)
        .select('id')
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .eq('status', 'pending')
        .maybeSingle();

    return data != null;
  }

  // البث الحي واللحظي لطلبات المايك المعلقة ليراها المالك والمشرفون في لوحة التحكم فوراً
  Stream<List<MicRequestModel>> streamPendingRequests(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where(
            (e) => e['room_id'] == roomId && e['status'] == 'pending',
          ).toList();

          // فرز تصاعدي عادل (الأقدم في التقديم يظهر أولاً في قائمة الانتظار)
          filtered.sort(
            (a, b) => DateTime.parse(a['created_at'].toString()).compareTo(
              DateTime.parse(b['created_at'].toString()),
            ),
          );

          return filtered.map(MicRequestModel.fromMap).toList();
        });
  }
}
