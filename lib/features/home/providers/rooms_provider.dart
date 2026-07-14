import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/home/data/repositories/home_repository.dart';
import 'package:joojo_chat/features/home/domain/entities/room_entity.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(),
);

final roomsProvider =
    FutureProvider<List<RoomEntity>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);

  return repository.getRooms();
});