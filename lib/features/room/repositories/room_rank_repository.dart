import 'package:joojo_chat/features/room/models/room_rank_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomRankRepository {
  RoomRankRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_ranks';

  // جلب قائمة التصنيفات لغرفة معينة بناءً على النوع (مثل: gifter, speaker, user)
  Future<List<RoomRankModel>> getRanks({
    required String roomId,
    required String rankType,
    int limit = 50,
  }) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('rank_type', rankType)
        .order('score', ascending: false) // الترتيب التنازلي حسب السكور الأعلى
        .limit(limit);

    return (data as List)
        .map(
          (e) => RoomRankModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب التصنيف الحالي لمستخدم معين داخل غرفة محددة بناءً على نوع التصنيف
  Future<RoomRankModel?> getUserRank({
    required String roomId,
    required String userId,
    required String rankType,
  }) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .eq('rank_type', rankType)
        .maybeSingle();

    if (data == null) return null;

    return RoomRankModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // تحديث نقاط وتفاصيل تصنيف المستخدم أو إنشائه إذا لم يكن موجوداً
  Future<void> upsertRank(
    RoomRankModel rank,
  ) async {
    await _client
        .from(_table)
        .upsert(
          rank.copyWith(
            updatedAt: DateTime.now(),
          ).toMap(),
        );
  }

  // تحديث سكور العضو بشكل تراكمي عند إرسال الهدايا أو التحدث أو الشات
  Future<void> incrementRankScore({
    required String roomId,
    required String userId,
    required String rankType,
    required int scoreIncrement,
    int giftsIncrement = 0,
    int giftValueIncrement = 0,
    int messagesIncrement = 0,
    int speakingTimeIncrement = 0,
  }) async {
    // جلب السجل الحالي أولاً لضمان زيادة دقيقة وضمان عدم تداخل البيانات
    final current = await _client
        .from(_table)
        .select('score, gifts, gift_value, messages, speaking_time')
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .eq('rank_type', rankType)
        .maybeSingle();

    final int currentScore = (current?['score'] as num?)?.toInt() ?? 0;
    final int currentGifts = (current?['gifts'] as num?)?.toInt() ?? 0;
    final int currentGiftValue = (current?['gift_value'] as num?)?.toInt() ?? 0;
    final int currentMessages = (current?['messages'] as num?)?.toInt() ?? 0;
    final int currentSpeakingTime = (current?['speaking_time'] as num?)?.toInt() ?? 0;

    await _client.from(_table).upsert({
      'room_id': roomId,
      'user_id': userId,
      'rank_type': rankType,
      'score': currentScore + scoreIncrement,
      'gifts': currentGifts + giftsIncrement,
      'gift_value': currentGiftValue + giftValueIncrement,
      'messages': currentMessages + messagesIncrement,
      'speaking_time': currentSpeakingTime + speakingTimeIncrement,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  // إعادة تعيين (تصفير) لوحة الصدارة لغرفة معينة (تُستخدم عند تجديد الترتيب أسبوعياً أو شهرياً)
  Future<void> resetRoomRanks({
    required String roomId,
    String? rankType,
  }) async {
    var query = _client.from(_table).delete().eq('room_id', roomId);

    if (rankType != null) {
      query = query.eq('rank_type', rankType);
    }

    await query;
  }

  // البث الحي والمستمر لقائمة الصدارة داخل الغرفة لمزامنة الهدايا والتنافس (Real-time Stream)
  Stream<List<RoomRankModel>> streamRanks({
    required String roomId,
    required String rankType,
  }) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows
              .where((e) => e['room_id'] == roomId && e['rank_type'] == rankType)
              .toList();

          // ترتيب تنازلي للمستخدمين بناءً على السكور الفعلي لترتيب المقاعد والمراكز
          filtered.sort(
            (a, b) => (b['score'] as num? ?? 0)
                .compareTo(a['score'] as num? ?? 0),
          );

          return filtered.map(RoomRankModel.fromMap).toList();
        });
  }
}
