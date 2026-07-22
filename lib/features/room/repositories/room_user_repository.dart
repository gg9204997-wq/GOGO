import 'package:joojo_chat/features/room/models/room_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomUserRepository {
  RoomUserRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_users';

  // جلب كافة المستخدمين المتواجدين حالياً داخل الغرفة (وليسوا محظورين)
  Future<List<RoomUserModel>> getActiveUsers(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('is_banned', false)
        .order('joined_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomUserModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب بيانات مستخدم محدد داخل الغرفة الصوتية عبر معرف الغرفة والمستخدم
  Future<RoomUserModel?> getRoomUser({
    required String roomId,
    required String userId,
  }) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .maybeSingle();

    if (data == null) return null;

    return RoomUserModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // تسجيل دخول مستخدم إلى الغرفة أو تحديث بياناته الحالية (Upsert)
  Future<void> saveRoomUser(
    RoomUserModel roomUser,
  ) async {
    await _client
        .from(_table)
        .upsert(
          roomUser.copyWith(
            updatedAt: DateTime.now(),
          ).toMap(),
        );
  }

  // تحديث رول وصلاحيات المستخدم الإدارية (مثل ترقيته إلى Moderator أو إعادته لمستخدم عادي)
  Future<void> updateUserRole({
    required String roomId,
    required String userId,
    required String role,
    required bool isModerator,
    required bool isOwner,
  }) async {
    await _client
        .from(_table)
        .update({
          'role': role,
          'is_moderator': isModerator,
          'is_owner': isOwner,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('room_id', roomId)
        .eq('user_id', userId);
  }

  // تحديث حالة كتم الصوت للمستخدم من قِبل المشرفين (Mute/Unmute)
  Future<void> updateMuteStatus({
    required String roomId,
    required String userId,
    required bool isMuted,
  }) async {
    await _client
        .from(_table)
        .update({
          'is_muted': isMuted,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('room_id', roomId)
        .eq('user_id', userId);
  }

  // تحديث حالة حظر المستخدم داخل الغرفة (Ban/Unban)
  Future<void> updateBanStatus({
    required String roomId,
    required String userId,
    required bool isBanned,
  }) async {
    await _client
        .from(_table)
        .update({
          'is_banned': isBanned,
          'seat_number': -1, // إزاحته تلقائياً من المقعد الصوتي عند الحظر
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('room_id', roomId)
        .eq('user_id', userId);
  }

  // حجز مقعد صوتي للمستخدم أو تعديله أو المغادرة منه (-1 تعني ليس على المقعد)
  Future<void> updateSeatNumber({
    required String roomId,
    required String userId,
    required int seatNumber,
  }) async {
    await _client
        .from(_table)
        .update({
          'seat_number': seatNumber,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('room_id', roomId)
        .eq('user_id', userId);
  }

  // خروج المستخدم من الغرفة (حذف السجل بالكامل أو إزالته من الغرفة)
  Future<void> leaveRoom({
    required String roomId,
    required String userId,
  }) async {
    await _client
        .from(_table)
        .delete()
        .eq('room_id', roomId)
        .eq('user_id', userId);
  }

  // البث المباشر لقائمة الأعضاء المتواجدين حالياً داخل الغرفة لتحديث قائمة الحضور والمقاعد
  Stream<List<RoomUserModel>> streamActiveUsers(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where(
            (e) => e['room_id'] == roomId && e['is_banned'] == false,
          ).toList();

          // ترتيب ذكي: وضع من يمتلك مقعداً صوتياً أولاً (حسب رقم المقعد)، ثم البقية تنازلياً حسب وقت الانضمام
          filtered.sort((a, b) {
            final int aSeat = (a['seat_number'] as num?)?.toInt() ?? -1;
            final int bSeat = (b['seat_number'] as num?)?.toInt() ?? -1;

            if (aSeat >= 0 && bSeat >= 0) return aSeat.compareTo(bSeat);
            if (aSeat >= 0) return -1;
            if (bSeat >= 0) return 1;

            return DateTime.parse(b['joined_at'].toString()).compareTo(
              DateTime.parse(a['joined_at'].toString()),
            );
          });

          return filtered.map(RoomUserModel.fromMap).toList();
        });
  }
}
