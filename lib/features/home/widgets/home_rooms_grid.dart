import 'package:flutter/material.dart';

import 'package:joojo_chat/features/home/models/room_model.dart';
import 'package:joojo_chat/features/home/widgets/room_card.dart';

import 'package:joojo_chat/core/theme/app_spacing.dart';

class HomeRoomsGrid extends StatelessWidget {
  final List<RoomModel> rooms;

  const HomeRoomsGrid({
    super.key,
    required this.rooms,
  });

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Text(
            'لا توجد غرف',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    return Padding(
      padding: AppSpacing.card,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rooms.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: .72,
        ),
        itemBuilder: (context, index) {
          final room = rooms[index];

          return RoomCard(
            roomName: room.roomName,
            ownerName: room.ownerName,
            coverImage: room.coverImage,
            ownerAvatar: room.ownerAvatar,
            countryFlag: room.countryFlag,
            members: room.members,
            isLive: room.isLive,
            isVip: room.isVip,
          );
        },
      ),
    );
  }
}