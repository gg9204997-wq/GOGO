import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/home/models/room_model.dart';
import 'package:joojo_chat/features/home/repository/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(),
);

final roomsProvider =
    FutureProvider<List<RoomModel>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);

  return repository.getRooms();
});