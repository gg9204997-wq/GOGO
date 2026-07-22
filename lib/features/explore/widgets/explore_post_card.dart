import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/explore/models/explore_post_model.dart';

class ExplorePostCard extends StatelessWidget {
  final ExplorePostModel post;
  final VoidCallback onLikeTap;

  const ExplorePostCard({
    required this.post,
    required this.onLikeTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color purpleNeon = Color(0xff8A5CFF);
    const Color goldColor = Color(0xffFFD700);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xff120D1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: purpleNeon.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رأس الكارت: بيانات المستخدم والشارات الملكية
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xff1A1435),
                backgroundImage: post.userAvatar.isNotEmpty ? CachedNetworkImageProvider(post.userAvatar) : null,
                child: post.userAvatar.isEmpty ? const Icon(Icons.person, color: Colors.white24, size: 18) : null,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(post.username, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                      const SizedBox(width: 4),
                      if (post.vipLevel > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0.5),
                          decoration: BoxDecoration(gradient: const LinearGradient(colors: [goldColor, Colors.orange]), borderRadius: BorderRadius.circular(4)),
                          // تم استبدال الكلمة المستبعدة بـ FontWeight.w900 لحل خطأ undefined_getter والـ invalid_constant
                          child: Text('VIP ${post.vipLevel}', style: const TextStyle(color: Colors.black, fontSize: 7, fontWeight: FontWeight.w900)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0.5),
                    decoration: BoxDecoration(color: purpleNeon, borderRadius: BorderRadius.circular(4)),
                    child: Text('Lv.${post.userLevel}', style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz_rounded, color: Colors.white30, size: 18),
            ],
          ),
          const SizedBox(height: 10),

          // نص اليوميات المكتوب (تم إصلاح كود اللون للدرجة المدعومة رسمياً بالملي)
          Text(
            post.contentText,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 11.5, fontFamily: 'Cairo', height: 1.4),
          ),
          const SizedBox(height: 8),

          // صورة المنشور الحية مغلّفة بحواف نيون زجاجية فخمة
          if (post.postImage.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: post.postImage,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
                // تم إصلاح كود اللون للدرجة الشفافة القياسية بالملي
                placeholder: (context, url) => Container(color: Colors.white.withValues(alpha: 0.05)),
              ),
            ),
          const SizedBox(height: 10),

          // أزرار التفاعل اللحظية السفلى (اللايكات والتعليقات النشطة)
          Row(
            children: [
              GestureDetector(
                onTap: onLikeTap,
                child: Row(
                  children: [
                    Icon(post.isLikedByMe ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: post.isLikedByMe ? Colors.red : Colors.white54, size: 16),
                    const SizedBox(width: 4),
                    Text('${post.likesCount}', style: const TextStyle(color: Colors.white54, fontSize: 10)),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white54, size: 16),
                  const SizedBox(width: 4),
                  Text('${post.commentsCount}', style: const TextStyle(color: Colors.white54, fontSize: 10)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
