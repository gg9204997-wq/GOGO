import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/home/domain/entities/room_entity.dart';
import 'package:joojo_chat/features/home/providers/rooms_provider.dart';

final homeControllerProvider =
    AsyncNotifierProvider<HomeController, List<RoomEntity>>(
  HomeController.new,
);

class HomeController extends AsyncNotifier<List<RoomEntity>> {
  @override
  Future<List<RoomEntity>> build() async {
    return ref.read(homeRepositoryProvider).getRooms();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => ref.read(homeRepositoryProvider).getRooms(),
    );
  }

  Future<void> search(String keyword) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => ref.read(homeRepositoryProvider).searchRooms(keyword),
    );
  }

  Future<void> category(String category) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => ref.read(homeRepositoryProvider).getCategory(category),
    );
  }
}