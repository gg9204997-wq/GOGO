import 'package:joojo_chat/features/room/models/room_music_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomMusicRepository {
  RoomMusicRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_music';

  // جلب قائمة الأغاني المضافة داخل غرفة معينة مرتبة حسب وقت الإضافة
  Future<List<RoomMusicModel>> getPlaylist(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('created_at', ascending: true);

    return (data as List)
        .map(
          (e) => RoomMusicModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  // جلب الموسيقى التي تعمل حالياً داخل الغرفة
  Future<RoomMusicModel?> getCurrentPlaying(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('is_playing', true)
        .maybeSingle();

    if (data == null) return null;

    return RoomMusicModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  // إضافة أغنية جديدة إلى قائمة التشغيل (Playlist) الخاصة بالغرفة
  Future<String> addMusic(
    RoomMusicModel music,
  ) async {
    final data = await _client
        .from(_table)
        .insert(music.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  // تحديث حالة التشغيل والموضع الحالي للموسيقى (مزامنة الوقت بين المستخدمين)
  Future<void> updatePlayback({
    required String id,
    required bool isPlaying,
    required int position,
  }) async {
    await _client
        .from(_table)
        .update({
          'is_playing': isPlaying,
          'position': position,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // تحديث كائن الموسيقى بالكامل
  Future<void> update(
    RoomMusicModel music,
  ) async {
    await _client
        .from(_table)
        .update(
          music.copyWith(
            updatedAt: DateTime.now(),
          ).toMap(),
        )
        .eq('id', music.id);
  }

  // إيقاف الأغنية الحالية (Pause)
  Future<void> pauseMusic(
    String id,
  ) async {
    await _client
        .from(_table)
        .update({
          'is_playing': false,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  // حذف أغنية من قائمة التشغيل نهائياً
  Future<void> removeMusic(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  // تصفير أو حذف قائمة التشغيل بالكامل للغرفة
  Future<void> clearPlaylist(
    String roomId,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('room_id', roomId);
  }

  // البث الحي لمزامنة تشغيل الموسيقى والوقت الحالي (Position) لحظياً مع جميع الأعضاء
  Stream<List<RoomMusicModel>> streamPlaylist(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where((e) => e['room_id'] == roomId).toList();

          filtered.sort(
            (a, b) => DateTime.parse(a['created_at'].toString()).compareTo(
              DateTime.parse(b['created_at'].toString()),
            ),
          );

          return filtered.map(RoomMusicModel.fromMap).toList();
        });
  }
}
