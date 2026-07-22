// Path: lib/features/rooms/pages/room_page.dart

import 'package:flutter/material.dart';

class RoomPage extends StatelessWidget {
  final String roomId;

  const RoomPage({
    required this.roomId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090514),
      appBar: AppBar(
        backgroundColor: const Color(0xff090514),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'الغرفة $roomId',
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Room ID : $roomId',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
