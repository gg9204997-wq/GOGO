import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 110,
          height: 110,
        ),
        const SizedBox(height: 20),
        const Text(
          "JoJo Chat",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "منصة الدردشة الصوتية الاحترافية",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}