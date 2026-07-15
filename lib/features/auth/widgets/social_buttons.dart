import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback onGoogle;
  final VoidCallback onFacebook;

  const SocialButtons({
    super.key,
    required this.onGoogle,
    required this.onFacebook,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onGoogle,
            icon: const Icon(Icons.g_mobiledata, size: 30),
            label: const Text("Google"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white24),
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onFacebook,
            icon: const Icon(Icons.facebook),
            label: const Text("Facebook"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white24),
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}