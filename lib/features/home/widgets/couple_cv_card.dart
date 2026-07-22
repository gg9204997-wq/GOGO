import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/home/models/couple_cv_model.dart';

class CoupleCvCard extends StatelessWidget {
  final CoupleCvModel coupleData;
  final VoidCallback onTap;

  const CoupleCvCard({
    required this.coupleData,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color cvColor = Color(0xffFF1493);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: cvColor.withValues(alpha: 0.6),
            width: 1.2,
          ),
          gradient: LinearGradient(
            colors: [cvColor.withValues(alpha: 0.12), Colors.black12],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 6),
            const Text(
              'CV',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10, // تصغير حجم نص الـ CV
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 4),
            _buildCoupleAvatars(),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'عرض الكل',
                    style: TextStyle(
                      color: cvColor,
                      fontSize: 7,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: cvColor, size: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoupleAvatars() {
    final String p1 = coupleData.partnerOneAvatar.isNotEmpty ? coupleData.partnerOneAvatar : 'https://dicebear.com';
    final String p2 = coupleData.partnerTwoAvatar.isNotEmpty ? coupleData.partnerTwoAvatar : 'https://dicebear.com';

    return SizedBox(
      width: 32,
      height: 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.pink.shade700, width: 1),
              ),
              child: CircleAvatar(
                radius: 8, // تصغير دوائر القلوب المرتبطة لتتناسب مع الهيكل المربع الفخم الجديد بالملي
                backgroundColor: Colors.black.withValues(alpha: 0.25),
                backgroundImage: CachedNetworkImageProvider(p1),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red.shade700, width: 1),
              ),
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.black.withValues(alpha: 0.25),
                backgroundImage: CachedNetworkImageProvider(p2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
