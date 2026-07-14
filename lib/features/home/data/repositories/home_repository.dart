import 'package:joojo_chat/features/home/domain/entities/room_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepository {
  HomeRepository();

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<RoomEntity>> getRooms() async {
    final response = await _supabase
        .from('rooms')
        .select()
        .order('members', ascending: false);

    return response
        .map<RoomEntity>(
          RoomEntity.fromMap,
        )
        .toList();
  }

  Future<List<RoomEntity>> searchRooms(String keyword) async {
    final response = await _supabase
        .from('rooms')
        .select()
        .ilike('room_name', '%$keyword%');

    return response
        .map<RoomEntity>(
          RoomEntity.fromMap,
        )
        .toList();
  }

  Future<List<RoomEntity>> getCategory(String category) async {
    final response = await _supabase
        .from('rooms')
        .select()
        .eq('category', category);

    return response
        .map<RoomEntity>(
          RoomEntity.fromMap,
        )
        .toList();
  }
}