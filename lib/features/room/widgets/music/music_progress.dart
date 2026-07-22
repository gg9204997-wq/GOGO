import 'package:flutter/material.dart';

class MusicProgress extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<double>? onChanged;

  const MusicProgress({
    super.key,
    required this.position,
    required this.duration,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final total =
        duration.inMilliseconds == 0
            ? 1
            : duration.inMilliseconds;

    final value =
        (position.inMilliseconds / total)
            .clamp(0.0, 1.0);

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape:
                const RoundSliderThumbShape(
              enabledThumbRadius: 7,
            ),
            overlayShape:
                const RoundSliderOverlayShape(
              overlayRadius: 14,
            ),
            activeTrackColor:
                const Color(0xff8A5CFF),
            inactiveTrackColor:
                Colors.white12,
            thumbColor:
                const Color(0xff8A5CFF),
          ),
          child: Slider(
            value: value,
            onChanged: (v) {
              onChanged?.call(v);
            },
          ),
        ),

        Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Text(
                _format(position),
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),

              const Spacer(),

              Text(
                _format(duration),
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _format(Duration d) {
    final minutes =
        d.inMinutes.remainder(60);

    final seconds =
        d.inSeconds.remainder(60);

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}