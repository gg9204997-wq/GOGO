// Path: lib/features/room/create_room_page.dart
import 'package:flutter/material.dart';

class CreateRoomPage extends StatelessWidget {
  // 1. تعريف متغير الـ userId اللي جاي من الـ Router
  final String userId; 

  // 2. استقباله بشكل إجباري في الكونسيركتور
  const CreateRoomPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090514),
      appBar: AppBar(
        title: const Text('إنشاء غرفة جديدة', style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 16)),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'قريباً: واجهة إنشاء الغرف الصوتية 🎙️',
              style: TextStyle(color: Colors.white70, fontFamily: 'Cairo', fontSize: 14),
            ),
            const SizedBox(height: 8),
            // عرض الـ userId الممرر للتأكد من وصوله بنجاح
            Text(
              'معرّف المستخدم: $userId',
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}