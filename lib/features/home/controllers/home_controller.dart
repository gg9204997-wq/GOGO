import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/home/models/room_model.dart';
import 'package:joojo_chat/features/home/providers/rooms_provider.dart';

final homeControllerProvider =
    AsyncNotifierProvider<HomeController, List<RoomModel>>(
  HomeController.new,
);

class HomeController extends AsyncNotifier<List<RoomModel>> {
  @override
  Future<List<RoomModel>> build() async {
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