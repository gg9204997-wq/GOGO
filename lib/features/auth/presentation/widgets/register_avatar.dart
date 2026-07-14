import 'dart:io';

import 'package:flutter/material.dart';

class RegisterAvatar extends StatelessWidget {
  const RegisterAvatar({
    required this.profileImage, required this.onTap, super.key,
  });

  final File? profileImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.purpleAccent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.12),
                  blurRadius: 15,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFF140933),
              backgroundImage:
                  profileImage != null ? FileImage(profileImage!) : null,
              child: profileImage == null
                  ? const Icon(
                      Icons.camera_alt_outlined,
                      size: 35,
                      color: Colors.purpleAccent,
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}