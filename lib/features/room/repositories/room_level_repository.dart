import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/room_level_history_model.dart';


class RoomLevelRepository {

  final SupabaseClient supabase;


  RoomLevelRepository({
    SupabaseClient? client,
  }) : supabase = client ?? Supabase.instance.client;



  // =========================
  // GET LEVEL HISTORY
  // =========================

  Future<List<RoomLevelHistoryModel>> getHistory(
    String roomId,
  ) async {

    final response = await supabase
        .from('room_level_history')
        .select()
        .eq(
          'room_id',
          roomId,
        )
        .order(
          'created_at',
          ascending: false,
        );


    return response
        .map<RoomLevelHistoryModel>(
          (e) => RoomLevelHistoryModel.fromMap(e),
        )
        .toList();
  }



  // =========================
  // ADD LEVEL RECORD
  // =========================

  Future<void> addHistory(
    RoomLevelHistoryModel history,
  ) async {

    await supabase
        .from('room_level_history')
        .insert(
          history.toMap(),
        );
  }



  // =========================
  // GET CURRENT LEVEL
  // =========================

  Future<RoomLevelHistoryModel?>
      getLatestLevel(
    String roomId,
  ) async {

    final response = await supabase
        .from('room_level_history')
        .select()
        .eq(
          'room_id',
          roomId,
        )
        .order(
          'created_at',
          ascending: false,
        )
        .limit(1)
        .maybeSingle();


    if (response == null) {
      return null;
    }


    return RoomLevelHistoryModel.fromMap(
      response,
    );
  }



  // =========================
  // ADD XP
  // =========================

  Future<void> addXp({
    required String roomId,
    required int oldLevel,
    required int newLevel,
    required int xp,
    String? reason,
    String? createdBy,
  }) async {


    await supabase
        .from('room_level_history')
        .insert({

          'room_id': roomId,

          'old_level': oldLevel,

          'new_level': newLevel,

          'xp_added': xp,

          'reason': reason,

          'created_by': createdBy,

        });
  }



  // =========================
  // DELETE HISTORY
  // =========================

  Future<void> deleteHistory(
    String id,
  ) async {

    await supabase
        .from('room_level_history')
        .delete()
        .eq(
          'id',
          id,
        );
  }

}