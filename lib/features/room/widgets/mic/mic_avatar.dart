import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MicAvatar extends StatelessWidget {
  const MicAvatar({
    super.key,
    required this.imageUrl,
    this.size = 64,
    this.isSpeaking = false,
    this.isMuted = false,
    this.borderColor,
    this.onTap,
  });

  final String imageUrl;
  final double size;
  final bool isSpeaking;
  final bool isMuted;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        borderColor ??
        (isSpeaking ? Colors.greenAccent : Colors.white24);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 2,
          ),
          boxShadow: isSpeaking
              ? [
                  BoxShadow(
                    color: Colors.greenAccent.withValues(alpha: 0.45),
                    blurRadius: 18,
                    spreadRadius: 4,
                  ),
                ]
              : [],
        ),
        child: Stack(
          children: [
            ClipOval(
              child: imageUrl.isEmpty
                  ? Container(
                      color: Colors.grey.shade800,
                      child: Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: size * .55,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) {
                        return Container(
                          color: Colors.grey.shade800,
                          child: Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: size * .55,
                          ),
                        );
                      },
                    ),
            ),
            if (isMuted)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mic_off,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}