import 'package:joojo_chat/features/room/models/room_game_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomGameRepository {
  RoomGameRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_games';

  // جلب كل الألعاب التي تمت أو تجري داخل غرفة معينة
  Future<List<RoomGameModel>> getGames(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('created_at', ascending: false);

    return (data as List)
        .map(
          (e) => RoomGameModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب اللعبة النشطة أو الجارية حالياً داخل الغرفة (سواء في حالة الانتظار أو اللعب)
  Future<RoomGameModel?> getActiveGame(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .inFilter('status', ['waiting', 'running'])
        .order('created_at', ascending: false)
        .maybeSingle();

    if (data == null) return null;

    return RoomGameModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // جلب تفاصيل لعبة محددة بواسطة المعرف الخاص بها
  Future<RoomGameModel?> getGame(
    String id,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;

    return RoomGameModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إنشاء لعبة جديدة داخل الغرفة (تبدأ بحالة waiting افتراضياً)
  Future<String> create(
    RoomGameModel game,
  ) async {
    final data = await _client
        .from(_table)
        .insert(game.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // بدء اللعبة وتغيير حالتها إلى running وتحديث وقت البدء
  Future<void> startGame({
    required String id,
  }) async {
    await _client
        .from(_table)
        .update({
          'status': 'running',
          'started_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // إنهاء اللعبة وتحديد الفائز وتغيير الحالة إلى finished وتحديث وقت النهاية
  Future<void> finishGame({
    required String id,
    required String? winnerId,
  }) async {
    await _client
        .from(_table)
        .update({
          'status': 'finished',
          'winner_id': winnerId,
          'ended_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // تحديث قائمة اللاعبين الحاليين داخل اللعبة (انضمام أو مغادرة)
  Future<void> updatePlayers({
    required String id,
    required List<dynamic> players,
  }) async {
    await _client
        .from(_table)
        .update({
          'players': players,
        })
        .eq('id', id);
  }

  // تحديث إعدادات اللعبة أثناء مرحلة الانتظار
  Future<void> updateSettings({
    required String id,
    required Map<String, dynamic> settings,
  }) async {
    await _client
        .from(_table)
        .update({
          'settings': settings,
        })
        .eq('id', id);
  }

  // إلغاء اللعبة وحذفها نهائياً
  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  // البث الحي لحالة الألعاب داخل غرفة معينة لمزامنة اللاعبين فورياً (Real-time Stream)
  Stream<List<RoomGameModel>> streamGames(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where((e) => e['room_id'] == roomId).toList();

          // ترتيب الألعاب التنازلي لعرض أحدث لعبة في الأعلى دائماً
          filtered.sort(
            (a, b) => DateTime.parse(b['created_at'].toString()).compareTo(
              DateTime.parse(a['created_at'].toString()),
            ),
          );

          return filtered.map(RoomGameModel.fromMap).toList();
        });
  }
}
