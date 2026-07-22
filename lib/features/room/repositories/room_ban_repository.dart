import 'package:joojo_chat/features/room/models/room_ban_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomBanRepository {
  RoomBanRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_bans';

  // جلب كل عمليات الحظر داخل غرفة معينة
  Future<List<RoomBanModel>> getBans(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomBanModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب قائمة الحظر النشطة فقط داخل الغرفة
  Future<List<RoomBanModel>> getActiveBans(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('active', true)
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomBanModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب تفاصيل حظر محدد بواسطة المعرف الخاص به
  Future<RoomBanModel?> getBan(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return RoomBanModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إنشاء حظر جديد لمستخدم داخل الغرفة
  Future<String> ban(
    RoomBanModel banDetails,
  ) async {
    final data = await _client
        .from(_table)
        .insert(banDetails.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // فك الحظر عن مستخدم (تعطيل الحظر)
  Future<void> liftBan({
    required String id,
    required String liftedBy,
  }) async {
    await _client
        .from(_table)
        .update({
          'active': false,
          'lifted_by': liftedBy,
          'lifted_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // التحقق من حالة حظر المستخدم حالياً داخل الغرفة
  Future<bool> isUserBanned({
    required String roomId,
    required String userId,
  }) async {
    final data = await _client
        .from(_table)
        .select('id, expires_at, permanent')
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .eq('active', true);

    if ((data as List).isEmpty) return false;

    // فحص التاريخ إن لم يكن الحظر أبدياً
    for (final ban in data) {
      final isPermanent = ban['permanent'] as bool? ?? false;
      if (isPermanent) return true;

      if (ban['expires_at'] != null) {
        final expiresAt = DateTime.tryParse(ban['expires_at'].toString());
        if (expiresAt != null && expiresAt.isAfter(DateTime.now())) {
          return true; // الحظر المؤقت لا يزال سارياً
        }
      }
    }

    return false;
  }

  // تحديث بيانات الحظر بالكامل
  Future<void> update(
    RoomBanModel banDetails,
  ) async {
    await _client
        .from(_table)
        .update(
          banDetails.copyWith(
            updatedAt: DateTime.now(),
          ).toMap(),
        )
        .eq('id', banDetails.id);
  }

  // البث الحي لقائمة المحظورين داخل الغرفة (Real-time Stream)
  Stream<List<RoomBanModel>> streamBans(
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

          return filtered.map(RoomBanModel.fromMap).toList();
        });
  }
}
