import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final VoidCallback onRegister;

  const AuthFooter({
    super.key,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "ليس لديك حساب؟",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        TextButton(
          onPressed: onRegister,
          child: const Text(
            "إنشاء حساب",
            style: TextStyle(
              color: Color(0xff7B2EFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}