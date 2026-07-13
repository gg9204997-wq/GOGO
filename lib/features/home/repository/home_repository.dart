import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:joojo_chat/features/home/models/room_model.dart';

class HomeRepository {
  HomeRepository();

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<RoomModel>> getRooms() async {
    final response = await _supabase
        .from('rooms')
        .select()
        .order('members', ascending: false);

    return response
        .map<RoomModel>(
          (json) => RoomModel.fromMap(json),
        )
        .toList();
  }

  Future<List<RoomModel>> searchRooms(String keyword) async {
    final response = await _supabase
        .from('rooms')
        .select()
        .ilike('room_name', '%$keyword%');

    return response
        .map<RoomModel>(
          (json) => RoomModel.fromMap(json),
        )
        .toList();
  }

  Future<List<RoomModel>> getCategory(String category) async {
    final response = await _supabase
        .from('rooms')
        .select()
        .eq('category', category);

    return response
        .map<RoomModel>(
          (json) => RoomModel.fromMap(json),
        )
        .toList();
  }
}