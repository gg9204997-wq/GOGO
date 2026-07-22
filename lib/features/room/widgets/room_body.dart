import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:joojo_chat/features/room/providers/room_provider.dart';

import 'room_background.dart';
import 'room_chat.dart';
import 'room_header.dart';
import 'room_mic_grid.dart';
import 'room_user_bar.dart';

class RoomBody extends StatelessWidget {
  const RoomBody({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((RoomProvider p) => p.isLoading);

    final errorMessage =
        context.select((RoomProvider p) => p.errorMessage);

    final currentRoom =
        context.select((RoomProvider p) => p.currentRoom);

    if (isLoading && currentRoom == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    if (errorMessage != null && currentRoom == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'حدث خطأ: $errorMessage',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const RoomBackground(),

          SafeArea(
            child: Column(
              children: [
                const RoomHeader(),

                const RoomUserBar(),

                const SizedBox(height: 8),

                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: RoomMicGrid(),
                  ),
                ),
              ],
            ),
          ),

          RoomChat(
            isExpanded: false,
            onToggleExpand: () {},
          ),
        ],
      ),
    );
  }
}