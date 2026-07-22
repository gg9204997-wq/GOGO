import 'package:joojo_chat/features/room/models/room_statistics_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomStatisticsRepository {
  RoomStatisticsRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_statistics';

  // جلب إحصائيات غرفة معينة بواسطة معرف الغرفة
  Future<RoomStatisticsModel?> getStatistics(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .maybeSingle();

    if (data == null) return null;

    return RoomStatisticsModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // تحديث أو إنشاء سجل الإحصائيات بالكامل للغرفة
  Future<void> upsertStatistics(
    RoomStatisticsModel statistics,
  ) async {
    await _client
        .from(_table)
        .upsert(
          statistics.copyWith(
            updatedAt: DateTime.now(),
          ).toMap(),
        );
  }

  // تحديث الإحصائيات بشكل تراكمي ديناميكي عند حدوث أي نشاط داخل الغرفة الصوتية
  Future<void> incrementStatistics({
    required String roomId,
    int giftsIncrement = 0,
    int coinsIncrement = 0,
    int diamondsIncrement = 0,
    int messagesIncrement = 0,
    int visitorsIncrement = 0,
    int voiceMinutesIncrement = 0,
    int sessionsIncrement = 0,
    int todayGiftsIncrement = 0,
    int todayCoinsIncrement = 0,
    int todayDiamondsIncrement = 0,
  }) async {
    // جلب السجل الحالي أولاً لزيادة القيم التراكمية بدقة وتفادي التداخل في قواعد البيانات
    final current = await _client
        .from(_table)
        .select('''
          total_gifts, total_coins, total_diamonds, total_messages, 
          total_visitors, total_voice_minutes, total_sessions, 
          today_gifts, today_coins, today_diamonds
        ''')
        .eq('room_id', roomId)
        .maybeSingle();

    final int currentTotalGifts = (current?['total_gifts'] as num?)?.toInt() ?? 0;
    final int currentTotalCoins = (current?['total_coins'] as num?)?.toInt() ?? 0;
    final int currentTotalDiamonds = (current?['total_diamonds'] as num?)?.toInt() ?? 0;
    final int currentTotalMessages = (current?['total_messages'] as num?)?.toInt() ?? 0;
    final int currentTotalVisitors = (current?['total_visitors'] as num?)?.toInt() ?? 0;
    final int currentTotalVoiceMinutes = (current?['total_voice_minutes'] as num?)?.toInt() ?? 0;
    final int currentTotalSessions = (current?['total_sessions'] as num?)?.toInt() ?? 0;
    
    final int currentTodayGifts = (current?['today_gifts'] as num?)?.toInt() ?? 0;
    final int currentTodayCoins = (current?['today_coins'] as num?)?.toInt() ?? 0;
    final int currentTodayDiamonds = (current?['today_diamonds'] as num?)?.toInt() ?? 0;

    await _client.from(_table).upsert({
      'room_id': roomId,
      'total_gifts': currentTotalGifts + giftsIncrement,
      'total_coins': currentTotalCoins + coinsIncrement,
      'total_diamonds': currentTotalDiamonds + diamondsIncrement,
      'total_messages': currentTotalMessages + messagesIncrement,
      'total_visitors': currentTotalVisitors + visitorsIncrement,
      'total_voice_minutes': currentTotalVoiceMinutes + voiceMinutesIncrement,
      'total_sessions': currentTotalSessions + sessionsIncrement,
      'today_gifts': currentTodayGifts + todayGiftsIncrement,
      'today_coins': currentTodayCoins + todayCoinsIncrement,
      'today_diamonds': currentTodayDiamonds + todayDiamondsIncrement,
      'last_activity_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  // تحديث أعلى ذروة حضور للمستخدمين أونلاين في نفس الوقت (Peak Online)
  Future<void> updatePeakOnline({
    required String roomId,
    required int currentOnlineUsers,
  }) async {
    final current = await _client
        .from(_table)
        .select('peak_online')
        .eq('room_id', roomId)
        .maybeSingle();

    final int currentPeak = (current?['peak_online'] as num?)?.toInt() ?? 0;

    // نقوم بالتحديث فقط إذا تخطى العدد الحالي حاجز الذروة المسجل سابقاً
    if (currentOnlineUsers > currentPeak) {
      await _client.from(_table).update({
        'peak_online': currentOnlineUsers,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('room_id', roomId);
    }
  }

  // تصفير عدادات اليوم (Today Stats) وتُستدعى تلقائياً عبر وظيفة مجدولة يومياً (Cron Job)
  Future<void> resetDailyStatistics(
    String roomId,
  ) async {
    await _client
        .from(_table)
        .update({
          'today_gifts': 0,
          'today_coins': 0,
          'today_diamonds': 0,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('room_id', roomId);
  }

  // البث الحي لمراقبة لوحة إحصائيات الغرفة لحظياً من قبل الإدارة والمالك (Real-time Stream)
  Stream<RoomStatisticsModel?> streamStatistics(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['room_id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where((e) => e['room_id'] == roomId);

          if (filtered.isEmpty) {
            return null;
          }

          return RoomStatisticsModel.fromMap(filtered.first);
        });
  }
}
