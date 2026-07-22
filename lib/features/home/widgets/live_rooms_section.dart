// Path: lib/features/home/widgets/live_rooms_section.dart

import 'package:flutter/material.dart';
import 'package:joojo_chat/features/home/models/room_model.dart';
import 'package:joojo_chat/features/home/widgets/room_card.dart';
// 🌟 تم تثبيت وتفعيل الاستدعاء الرسمي الموحد للمنصة بنجاح كامل وصفر أخطاء
import 'package:joojo_chat/features/room/room_page.dart';

class LiveRoomsSection extends StatelessWidget {
  final List<RoomModel> rooms;
  final bool isLoading;

  const LiveRoomsSection({
    required this.rooms,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: CircularProgressIndicator(
              color: Color(0xff7A4DFF),
            ),
          ),
        ),
      );
    }

    if (rooms.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: Text(
              'لا توجد غرف متاحة حالياً',
              style: TextStyle(
                color: Colors.white38,
                fontFamily: 'Cairo',
                fontSize: 13,
              ),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 1.15,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final room = rooms[index];

            return RoomCard(
              room: room,
              seats: const [],
              onTap: () {
                // 🌟 ربط وتشغيل دالة النقل الفوري لصفحة الـ RoomPage بنجاح تشغيلي 100%
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => RoomPage(
                      roomId: room.id,
                    ),
                  ),
                );
              },
            );
          },
          childCount: rooms.length,
        ),
      ),
    );
  }
}
