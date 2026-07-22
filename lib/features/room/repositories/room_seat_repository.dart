import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/seat_model.dart';

class RoomSeatRepository {
  final SupabaseClient supabase;

  RoomSeatRepository({
    SupabaseClient? client,
  }) : supabase = client ?? Supabase.instance.client;

  // =========================
  // GET ROOM SEATS
  // =========================
  Future<List<SeatModel>> getSeats(
    String roomId,
  ) async {
    final response = await supabase
        .from('room_seats')
        .select()
        .eq('room_id', roomId)
        .order(
          'seat_number',
          ascending: true,
        );

    return response
        .map<SeatModel>(
          (e) => SeatModel.fromMap(e),
        )
        .toList();
  }

  // =========================
  // TAKE SEAT
  // =========================
  Future<void> takeSeat({
    required String roomId,
    required String userId,
    required int seatNumber,
  }) async {
    await supabase
        .from('room_seats')
        .update({
          'user_id': userId,
          'mic_on': false,
          'is_muted': false,
          'is_speaking': false,
          'joined_at': DateTime.now().toIso8601String(),
        })
        .eq('room_id', roomId)
        .eq('seat_number', seatNumber);
  }

  // =========================
  // LEAVE SEAT
  // =========================
  Future<void> leaveSeat({
    required String roomId,
    required int seatNumber,
  }) async {
    await supabase
        .from('room_seats')
        .update({
          'user_id': null,
          'mic_on': false,
          'is_speaking': false,
          'is_muted': false,
          'joined_at': null,
        })
        .eq('room_id', roomId)
        .eq('seat_number', seatNumber);
  }

  // =========================
  // TOGGLE MIC
  // =========================
  Future<void> toggleMic({
    required String roomId,
    required int seatNumber,
    required bool enabled,
  }) async {
    await supabase
        .from('room_seats')
        .update({
          'mic_on': enabled,
        })
        .eq('room_id', roomId)
        .eq('seat_number', seatNumber);
  }

  // =========================
  // MUTE USER
  // =========================
  Future<void> muteSeat({
    required String roomId,
    required int seatNumber,
    required bool muted,
  }) async {
    await supabase
        .from('room_seats')
        .update({
          'is_muted': muted,
        })
        .eq('room_id', roomId)
        .eq('seat_number', seatNumber);
  }

  // =========================
  // UPDATE SPEAKING STATUS
  // =========================
  Future<void> updateSpeaking({
    required String roomId,
    required int seatNumber,
    required bool speaking,
  }) async {
    await supabase
        .from('room_seats')
        .update({
          'is_speaking': speaking,
        })
        .eq('room_id', roomId)
        .eq('seat_number', seatNumber);
  }

  // =========================
  // LOCK / UNLOCK SEAT
  // =========================
  Future<void> lockSeat({
    required String roomId,
    required int seatNumber,
    required bool locked,
  }) async {
    await supabase
        .from('room_seats')
        .update({
          'is_locked': locked,
        })
        .eq('room_id', roomId)
        .eq('seat_number', seatNumber);
  }

  // =========================
  // STREAM ROOM SEATS (الزيادة الإضافية الحية)
  // =========================
  Stream<List<SeatModel>> streamSeats(
    String roomId,
  ) {
    return supabase
        .from('room_seats')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .map((List<Map<String, dynamic>> rows) {
          // ترتيب تصاعدي صارم لضمان رسم شبكة المقاعد الصوتية بالترتيب الصحيح (0, 1, 2...) دون عشوائية
          rows.sort(
            (a, b) => (a['seat_number'] as num? ?? 0)
                .compareTo(b['seat_number'] as num? ?? 0),
          );

          return rows.map(SeatModel.fromMap).toList();
        });
  }
}
