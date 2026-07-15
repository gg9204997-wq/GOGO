import 'package:flutter/material.dart';

class RegisterAvatar extends StatelessWidget {
  const RegisterAvatar({
    required this.imageProvider,
    required this.onTap,
    super.key,
  });

  final ImageProvider? imageProvider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: const Color(0xFF1D2235),
            backgroundImage: imageProvider,
            child: imageProvider == null
                ? const Icon(
                    Icons.person,
                    size: 55,
                    color: Colors.white70,
                  )
                : null,
          ),
          Positioned(
            bottom: -2,
            right: -2,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF7B2EFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}