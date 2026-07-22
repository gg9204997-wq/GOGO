// Path: lib/features/auth/widgets/login_social_buttons.dart

import 'package:flutter/material.dart';

class LoginSocialButtons extends StatelessWidget {
  const LoginSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildBtn('Google', Icons.g_mobiledata_rounded, Colors.red),
            const SizedBox(width: 12),
            _buildBtn('Facebook', Icons.facebook_rounded, const Color(0xff1877F2)),
          ],
        ),
        const SizedBox(height: 18),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'تسجيل الدخول برقم الهاتف',
            style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500, fontFamily: 'Cairo'),
          ),
        ),
      ],
    );
  }

  Widget _buildBtn(String label, IconData icon, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xff120D1F),
            borderRadius: BorderRadius.circular(21),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 4),
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
