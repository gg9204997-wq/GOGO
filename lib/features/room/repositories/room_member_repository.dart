import 'package:joojo_chat/features/room/models/room_member_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomMemberRepository {
  RoomMemberRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_members';

  // جلب جميع الأعضاء الحاليين داخل غرفة معينة
  Future<List<RoomMemberModel>> getMembers(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('joined_at');

    return (data as List)
        .map(
          (e) => RoomMemberModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب قائمة الأعضاء المتواجدين أونلاين فقط داخل الغرفة
  Future<List<RoomMemberModel>> getOnlineMembers(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('is_online', true)
        .order('joined_at');

    return (data as List)
        .map(
          (e) => RoomMemberModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب بيانات عضو محدد داخل غرفة معينة بواسطة معرف الغرفة والمستخدم
  Future<RoomMemberModel?> getMember({
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

    return RoomMemberModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إضافة مستخدم جديد كعضو في الغرفة عند الدخول
  Future<String> join(
    RoomMemberModel member,
  ) async {
    final data = await _client
        .from(_table)
        .insert(member.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // تحديث بيانات العضو بالكامل
  Future<void> update(
    RoomMemberModel member,
  ) async {
    await _client
        .from(_table)
        .update(
          member.copyWith(
            lastActive: DateTime.now(),
          ).toMap(),
        )
        .eq('id', member.id);
  }

  // تحديث حالة الاتصال وهل المستخدم متواجد بالاتصال أم غادر
  Future<void> updateOnlineStatus({
    required String id,
    required bool isOnline,
  }) async {
    final Map<String, dynamic> updates = {
      'is_online': isOnline,
      'last_active': DateTime.now().toIso8601String(),
    };

    if (!isOnline) {
      updates['left_at'] = DateTime.now().toIso8601String();
      updates['seat_number'] = null; // إخلاء المقعد تلقائياً عند الخروج
      updates['is_speaker'] = false;
    }

    await _client.from(_table).update(updates).eq('id', id);
  }

  // حجز أو تغيير مقعد العضو (Seat Management)
  Future<void> updateSeat({
    required String id,
    required int? seatNumber,
  }) async {
    await _client
        .from(_table)
        .update({
          'seat_number': seatNumber,
          'is_speaker': seatNumber != null,
          'last_active': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // كتم أو تفعيل صوت العضو (Mute/Unmute)
  Future<void> toggleMute({
    required String id,
    required bool isMuted,
  }) async {
    await _client
        .from(_table)
        .update({
          'is_muted': isMuted,
          'last_active': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // تفعيل أو غلق المايك من طرف العضو نفسه
  Future<void> toggleMic({
    required String id,
    required bool micEnabled,
  }) async {
    await _client
        .from(_table)
        .update({
          'mic_enabled': micEnabled,
          'last_active': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // تحديث محفظة الدعم والعملات المرسلة من العضو داخل الغرفة
  Future<void> incrementContributions({
    required String id,
    required int additionalDiamonds,
    required int additionalCoins,
  }) async {
    final current = await _client.from(_table).select('diamonds_sent, coins_sent').eq('id', id).single();
    final int currentDiamonds = (current['diamonds_sent'] as num?)?.toInt() ?? 0;
    final int currentCoins = (current['coins_sent'] as num?)?.toInt() ?? 0;

    await _client
        .from(_table)
        .update({
          'diamonds_sent': currentDiamonds + additionalDiamonds,
          'coins_sent': currentCoins + additionalCoins,
        })
        .eq('id', id);
  }

  // البث الحي للأعضاء الحاليين داخل الغرفة لمزامنة المايكات والمقاعد (Real-time Stream)
  Stream<List<RoomMemberModel>> streamMembers(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where(
            (e) => e['room_id'] == roomId && e['is_online'] == true,
          ).toList();

          filtered.sort((a, b) {
            final aSeat = a['seat_number'] as int?;
            final bSeat = b['seat_number'] as int?;
            if (aSeat != null && bSeat != null) return aSeat.compareTo(bSeat);
            if (aSeat != null) return -1;
            if (bSeat != null) return 1;
            return DateTime.parse(a['joined_at'].toString()).compareTo(
              DateTime.parse(b['joined_at'].toString()),
            );
          });

          return filtered.map(RoomMemberModel.fromMap).toList();
        });
  }
}
