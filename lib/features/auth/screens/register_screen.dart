import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            backgroundColor: const Color(0xFF1B0E3D),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.purpleAccent,
                size: 20,
              ),
              onPressed: onBack,
            ),
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "إنشاء حساب جديد",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          "انضم إلينا وابدأ رحلتك الصوتية الآن 💜",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 25),
      ],
    );
  }
}