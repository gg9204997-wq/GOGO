import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:joojo_chat/features/home/models/agency_model.dart';
import 'package:joojo_chat/features/home/models/celebrity_model.dart';
import 'package:joojo_chat/features/home/models/family_model.dart';
import 'package:joojo_chat/features/home/models/room_model.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// ===========================
/// Live Rooms
/// ===========================

final liveRoomsStreamProvider =
    StreamProvider.family<List<RoomModel>, String>(
  (ref, countryName) {
    final supabase = ref.watch(supabaseClientProvider);

    return supabase
        .from('rooms')
        .stream(primaryKey: ['id'])
        .eq('country', countryName)
        .order('heat', ascending: false)
        .map(
          (rows) => rows
              .map(
                (e) => RoomModel.fromMap(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList(),
        );
  },
);

/// ===========================
/// Top Celebrities
/// ===========================

final topCelebritiesProvider =
    FutureProvider<List<CelebrityModel>>(
  (ref) async {
    final supabase = ref.watch(supabaseClientProvider);

    final response = List<Map<String, dynamic>>.from(
      await supabase
          .from('profiles')
          .select()
          .eq('verified', true)
          .eq('is_banned', false)
          .order('followers', ascending: false)
          .limit(3),
    );

    return response
        .map((e) => CelebrityModel.fromMap(e))
        .toList();
  },
);

/// ===========================
/// Top Agencies
/// ===========================

final topAgenciesProvider =
    FutureProvider<List<AgencyModel>>(
  (ref) async {
    final supabase = ref.watch(supabaseClientProvider);

    final response = List<Map<String, dynamic>>.from(
      await supabase
          .from('agencies')
          .select()
          .order('income', ascending: false)
          .limit(3),
    );

    return response
        .map((e) => AgencyModel.fromMap(e))
        .toList();
  },
);

/// ===========================
/// Top Families
/// ===========================

final topFamiliesProvider =
    FutureProvider<List<FamilyModel>>(
  (ref) async {
    final supabase = ref.watch(supabaseClientProvider);

    final response = List<Map<String, dynamic>>.from(
      await supabase
          .from('families')
          .select()
          .order('points', ascending: false)
          .limit(3),
    );

    return response
        .map((e) => FamilyModel.fromMap(e))
        .toList();
  },
);