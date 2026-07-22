import 'package:flutter/material.dart';

class RoomBottomBar extends StatelessWidget {
  // 1. إصلاح الـ Super Parameter هنا
  const RoomBottomBar({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      // 2. تم تغيير black25 غير الموجودة إلى black38
      color: Colors.black38, 
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                // 3. تم استبدال withOpacity بـ withValues لتجنب الـ Deprecation
                color: Colors.white.withValues(alpha: 0.1), 
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'اكتب رسالتك...',
                  hintStyle: TextStyle(color: Colors.white30, fontSize: 13),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.sentiment_satisfied_alt, color: Colors.white54),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.white),
            style: IconButton.styleFrom(backgroundColor: Colors.blueAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.auto_awesome, color: Colors.amber),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.card_giftcard, color: Colors.pinkAccent, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}