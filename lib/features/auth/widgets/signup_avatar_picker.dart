// Path: lib/features/auth/widgets/signup_avatar_picker.dart

import 'package:flutter/material.dart';

class SignupAvatarPicker extends StatelessWidget {
  final VoidCallback onPickTap;

  const SignupAvatarPicker({
    required this.onPickTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color goldColor = Color(0xffFFD700);

    return Column(
      children: [
        const SizedBox(height: 16),
        GestureDetector(
          onTap: onPickTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // الهالة الترحيبية الدائرية المتوهجة بالذهب بالملي كالصورة
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff120D1F),
                  border: Border.all(color: goldColor.withValues(alpha: 0.35), width: 1.5),
                  boxShadow: [
                    BoxShadow(color: goldColor.withValues(alpha: 0.08), blurRadius: 15),
                  ],
                ),
                // 🌟 تم تصحيح كود اللون هنا للشفافية المدعومة رسمياً ليتنحى الخطأ فوراً
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 26,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
