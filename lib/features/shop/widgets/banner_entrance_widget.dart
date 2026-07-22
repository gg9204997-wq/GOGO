import 'package:flutter/material.dart';

class BannerEntranceWidget extends StatelessWidget {
  final String username;
  final int vipLevel;
  final String customMessage;

  const BannerEntranceWidget({
    required this.username,
    required this.vipLevel,
    this.customMessage = 'دخل الغرفة بموكب ملكي فخم 👑',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color neonGold = Color(0xffFFD700);

    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        // تدرج زجاجي بنفسجي ملكي فخم ليتناسب مع هوية التطبيق البصرية
        gradient: LinearGradient(
          colors: [
            const Color(0xffA277FF).withValues(alpha: 0.35),
            const Color(0xff120D1F).withValues(alpha: 0.85),
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffA277FF).withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffA277FF).withValues(alpha: 0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          // شارة رقم الـ VIP الذهبية المضيئة بالملي في بداية البانر
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [neonGold, Colors.amber]),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'VIP $vipLevel',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 10),
          
          // نص الترحيب الملكي المتحرك المنسق بالملي بخط القاهرة
          Expanded(
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 11),
                children: [
                  TextSpan(
                    text: '$username ',
                    style: const TextStyle(color: neonGold, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: customMessage,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
