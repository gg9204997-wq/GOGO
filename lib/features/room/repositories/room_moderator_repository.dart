import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:joojo_chat/features/room/models/room_moderator_model.dart';

class RoomModeratorRepository {
  RoomModeratorRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'room_moderators';

  Future<List<RoomModeratorModel>> getModerators(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .order('created_at');

    return (data as List)
        .map(
          (e) => RoomModeratorModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  Future<RoomModeratorModel?> getModerator({
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

    return RoomModeratorModel.fromMap(
      Map<String, dynamic>.from(data),
    );
  }

  Future<String> create(
    RoomModeratorModel moderator,
  ) async {
    final data = await _client
        .from(_table)
        .insert(moderator.toMap())
        .select()
        .single();

    return data['id'] as String;
  }

  Future<void> update(
    RoomModeratorModel moderator,
  ) async {
    await _client
        .from(_table)
        .update(
          moderator
              .copyWith(
                updatedAt: DateTime.now(),
              )
              .toMap(),
        )
        .eq('id', moderator.id);
  }

  Future<void> delete(
    String id,
  ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  Future<void> activate(
    String id,
  ) async {
    await _client
        .from(_table)
        .update({
          'active': true,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  Future<void> deactivate(
    String id,
  ) async {
    await _client
        .from(_table)
        .update({
          'active': false,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }  Future<void> updateRole({
    required String id,
    required String role,
  }) async {
    await _client
        .from(_table)
        .update({
          'role': role,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  Future<void> updatePermissions({
    required String id,
    required Map<String, dynamic> permissions,
  }) async {
    await _client
        .from(_table)
        .update({
          'permissions': permissions,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  Future<void> revoke({
    required String id,
    required String revokedBy,
  }) async {
    await _client
        .from(_table)
        .update({
          'active': false,
          'revoked_by': revokedBy,
          'revoked_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  Future<void> extend({
    required String id,
    DateTime? expiresAt,
  }) async {
    await _client
        .from(_table)
        .update({
          'expires_at': expiresAt?.toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  Future<bool> exists({
    required String roomId,
    required String userId,
  }) async {
    final data = await _client
        .from(_table)
        .select('id')
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .maybeSingle();

    return data != null;
  }

  Future<int> count(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select('id')
        .eq('room_id', roomId);

    return (data as List).length;
  }

  Future<List<RoomModeratorModel>> getActiveModerators(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .eq('active', true)
        .order('created_at');

    return (data as List)
        .map(
          (e) => RoomModeratorModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  Future<List<RoomModeratorModel>> getExpiredModerators(
    String roomId,
  ) async {
    final data = await _client
        .from(_table)
        .select()
        .eq('room_id', roomId)
        .not('expires_at', 'is', null);

    return (data as List)
        .map(
          (e) => RoomModeratorModel.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }  Stream<List<RoomModeratorModel>> streamModerators(
    String roomId,
  ) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows
              .where((e) => e['room_id'] == roomId)
              .toList();

          filtered.sort(
            (a, b) => DateTime.parse(
              a['created_at'].toString(),
            ).compareTo(
              DateTime.parse(
                b['created_at'].toString(),
              ),
            ),
          );

          return filtered
              .map(RoomModeratorModel.fromMap)
              .toList();
        });
  }

  Stream<RoomModeratorModel?> streamModerator({
    required String roomId,
    required String userId,
  }) {
    return _client
        .from(_table)
        .stream(primaryKey: ['id'])
        .map((List<Map<String, dynamic>> rows) {
          final filtered = rows.where(
            (e) =>
                e['room_id'] == roomId &&
                e['user_id'] == userId,
          );

          if (filtered.isEmpty) {
            return null;
          }

          return RoomModeratorModel.fromMap(
            filtered.first,
          );
        });
  }
}