import 'package:flutter/material.dart';

class RoomMicGrid extends StatelessWidget {
  const RoomMicGrid({super.key}); 

  @override
  Widget build(BuildContext context) {
    // تم تقليص الارتفاع إلى 23% لتوفير مساحة عمودية للشات ومنع الـ Overflow السفلي تماماً
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.23, 
      child: GridView.builder(
        shrinkWrap: true, 
        physics: const BouncingScrollPhysics(), 
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, 
          crossAxisSpacing: 8,
          mainAxisSpacing: 6, // تقليص الفراغ بين الصفوف قليلاً لتحسين التناسق
          childAspectRatio: 0.7, // ضبط النسبة لتتناسب مع الارتفاع الجديد وتمنع الأخطاء الداخلية
        ),
        itemCount: 20, 
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 48, // تصغير مرن وبسيط جداً للحفاظ على تناسق الأبعاد العمودية
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber.shade300, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 20, 
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                      child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 8)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                      child: const Icon(Icons.mic, color: Colors.green, size: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'مستخدم',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              const Text(
                '💎 12.5K',
                style: TextStyle(color: Colors.purpleAccent, fontSize: 9, fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}
