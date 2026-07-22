import 'package:flutter/material.dart';

class MusicControls extends StatelessWidget {
  final bool isPlaying;

  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onShuffle;
  final VoidCallback? onRepeat;

  const MusicControls({
    super.key,
    this.isPlaying = false,
    this.onPlay,
    this.onPause,
    this.onNext,
    this.onPrevious,
    this.onShuffle,
    this.onRepeat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff1F2230),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
        children: [
          _icon(
            Icons.shuffle,
            onShuffle,
          ),

          _icon(
            Icons.skip_previous_rounded,
            onPrevious,
          ),

          GestureDetector(
            onTap: isPlaying
                ? onPause
                : onPlay,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 250,
              ),
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff8A5CFF),
                    Color(0xff6F42FF),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xff8A5CFF,
                    ).withValues(alpha: .45),
                    blurRadius: 18,
                  ),
                ],
              ),
              child: Icon(
                isPlaying
                    ? Icons.pause
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),

          _icon(
            Icons.skip_next_rounded,
            onNext,
          ),

          _icon(
            Icons.repeat,
            onRepeat,
          ),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(20),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(
            alpha: .06,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}