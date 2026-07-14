import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/home/data/repositories/home_repository.dart';
import 'package:joojo_chat/features/home/domain/entities/room_entity.dart';
import 'package:joojo_chat/features/home/presentation/controllers/home_controller.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(),
);

final homeControllerProvider =
    AsyncNotifierProvider<HomeController, List<RoomEntity>>(
  HomeController.new,
);