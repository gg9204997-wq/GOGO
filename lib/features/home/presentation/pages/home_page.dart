import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';

import 'package:joojo_chat/features/home/domain/entities/room_entity.dart';
import 'package:joojo_chat/features/home/presentation/controllers/home_controller.dart';

import 'package:joojo_chat/features/home/presentation/widgets/home_banner_slider.dart';
import 'package:joojo_chat/features/home/presentation/widgets/home_category_cards.dart';
import 'package:joojo_chat/features/home/presentation/widgets/home_country_list.dart';
import 'package:joojo_chat/features/home/presentation/widgets/home_header.dart';
import 'package:joojo_chat/features/home/presentation/widgets/home_room_tabs.dart';
import 'package:joojo_chat/features/home/presentation/widgets/home_rooms_grid.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsState = ref.watch<AsyncValue<List<RoomEntity>>>(homeControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(homeControllerProvider.notifier).refresh();
          },
          child: roomsState.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (Object error, stack) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            data: (List<RoomEntity> rooms) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const HomeHeader(),

                  const SizedBox(height: 16),

                  const HomeBannerSlider(),

                  const SizedBox(height: 20),

                  const HomeCategoryCards(),

                  const SizedBox(height: 20),

                  const HomeCountryList(),

                  const SizedBox(height: 20),

                  const HomeRoomTabs(),

                  const SizedBox(height: 16),

                  HomeRoomsGrid(
                    rooms: rooms,
                  ),

                  const SizedBox(height: 120),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}