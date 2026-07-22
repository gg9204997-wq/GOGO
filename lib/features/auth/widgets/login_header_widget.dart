// Path: lib/features/auth/widgets/login_header_widget.dart

import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const Color goldColor = Color(0xffFFD700);

    return Column(
      children: [
        const SizedBox(height: 20),
        // 🌟 شعار جوجو شات الإمبراطوري المتوهج بالملي كالصورة
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: goldColor.withValues(alpha: 0.35), width: 1.5),
            boxShadow: [
              BoxShadow(color: goldColor.withValues(alpha: 0.08), blurRadius: 15),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'J',
                style: TextStyle(
                  color: goldColor,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Times New Roman',
                ),
              ),
              Text(
                'JOOJO\nCHAT',
                textAlign: TextAlign.center,
                style: TextStyle(color: goldColor, fontSize: 7, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'تسجيل الدخول',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
        ),
        const SizedBox(height: 4),
        Text(
          'مرحباً بك مجدداً',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 12, fontFamily: 'Cairo'),
        ),
      ],
    );
  }
}
