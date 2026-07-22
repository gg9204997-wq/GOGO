import 'dart:ui';

import 'package:flutter/material.dart';

class MusicPlayer extends StatelessWidget {
  final String title;
  final String artist;
  final String? cover;
  final bool isPlaying;

  final VoidCallback? onPlayPause;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onClose;

  const MusicPlayer({
    super.key,
    required this.title,
    required this.artist,
    this.cover,
    this.isPlaying = false,
    this.onPlayPause,
    this.onNext,
    this.onPrevious,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .35),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withValues(alpha: .08),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white10,
                  image: cover != null
                      ? DecorationImage(
                          image: NetworkImage(cover!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: cover == null
                    ? const Icon(
                        Icons.music_note,
                        color: Colors.white70,
                        size: 30,
                      )
                    : null,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        _smallButton(
                          Icons.skip_previous_rounded,
                          onPrevious,
                        ),

                        const SizedBox(width: 8),

                        GestureDetector(
                          onTap: onPlayPause,
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient:
                                  const LinearGradient(
                                colors: [
                                  Color(0xff8A5CFF),
                                  Color(0xff6E3FFF),
                                ],
                              ),
                            ),
                            child: Icon(
                              isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        _smallButton(
                          Icons.skip_next_rounded,
                          onNext,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: onClose,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _smallButton(
    IconData icon,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white10,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}