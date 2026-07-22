import 'package:joojo_chat/features/room/models/room_invite_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomInviteRepository {
  RoomInviteRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_invites';

  // جلب كل الدعوات المرسلة أو المستقبلة الخاصة بغرفة معينة
  Future<List<RoomInviteModel>> getRoomInvites(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomInviteModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب تفاصيل دعوة محددة بواسطة المعرف الخاص بها
  Future<RoomInviteModel?> getInvite(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return RoomInviteModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إرسال دعوة جديدة للانضمام إلى الغرفة (تبدأ بحالة pending افتراضياً)
  Future<String> send(
    RoomInviteModel invite,
  ) async {
    final data = await _client
        .from(_table)
        .insert(invite.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // تحديث حالة الدعوة (مثل: accepted, rejected) وتحديث وقت التعديل
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

  // جلب الدعوات المعلقة (pending) المرسلة بواسطة مستخدم معين
  Future<List<RoomInviteModel>> getSentInvites(
    String senderId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('sender_id', senderId)
        .eq('status', 'pending')
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomInviteModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب الدعوات المعلقة (pending) الواردة إلى مستخدم معين
  Future<List<RoomInviteModel>> getReceivedInvites(
    String receiverId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('receiver_id', receiverId)
        .eq('status', 'pending')
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomInviteModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // حذف دعوة أو إلغاؤها نهائياً
  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  // البث الحي للدعوات المعلقة الواردة للمستخدم لمزامنة التنبيهات فورياً (Real-time Stream)
  Stream<List<RoomInviteModel>> streamReceivedInvites(
    String receiverId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where(
            (e) => e['receiver_id'] == receiverId && e['status'] == 'pending',
          ).toList();

          filtered.sort(
            (a, b) => DateTime.parse(b['created_at'].toString()).compareTo(
              DateTime.parse(a['created_at'].toString()),
            ),
          );

          return filtered.map(RoomInviteModel.fromMap).toList();
        });
  }
}
