import 'package:flutter/material.dart';

class RoomUserBar extends StatelessWidget {
  const RoomUserBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // كأس الغرفة
          Row(
            children: const [
              Icon(Icons.wine_bar, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text('232.5K', style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 10),
            ],
          ),
          const Spacer(),
          // قائمة دائرية مصغرة للمتواجدين التوب
          SizedBox(
            width: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: true, // عشان يترصوا من اليمين لليسار
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.amber,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'), // استبدلها بصور حقيقية
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}