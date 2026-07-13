import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/features/home/controllers/home_controller.dart';
import 'package:joojo_chat/features/home/models/room_model.dart';
import 'package:joojo_chat/features/home/repository/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(),
);

final homeControllerProvider =
    AsyncNotifierProvider<HomeController, List<RoomModel>>(
  HomeController.new,
);