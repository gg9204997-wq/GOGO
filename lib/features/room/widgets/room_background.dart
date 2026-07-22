import 'package:flutter/material.dart';

class RoomBackground extends StatelessWidget {
  const RoomBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F0B21), // أسود مائل للبنفسجي الغامق في الأعلى
            Color(0xFF1A0B2E), // بنفسجي داكن في المنتصف
            Color(0xFF080413), // أسود داكن في الأسفل
          ],
        ),
      ),
    );
  }
}