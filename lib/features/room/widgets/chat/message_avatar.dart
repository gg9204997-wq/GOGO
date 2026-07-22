import 'package:flutter/material.dart';

class MessageAvatar extends StatelessWidget {
  const MessageAvatar({
    super.key,
    this.image,
    this.size = 42,
    this.online = false,
    this.verified = false,
    this.level,
    this.onTap,
  });

  final String? image;
  final double size;
  final bool online;
  final bool verified;
  final int? level;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white24,
                ),
              ),
              child: ClipOval(
                child: image != null &&
                        image!.isNotEmpty
                    ? Image.network(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey.shade700,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: size * .55,
                        ),
                      ),
              ),
            ),

            if (verified)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: const Icon(
                    Icons.verified,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),

            if (online)
              Positioned(
                right: 1,
                bottom: 1,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),

            if (level != null)
              Positioned(
                left: -6,
                bottom: -8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20),
                    gradient:
                        const LinearGradient(
                      colors: [
                        Color(0xffffc107),
                        Color(0xffff9800),
                      ],
                    ),
                  ),
                  child: Text(
                    "Lv.$level",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}