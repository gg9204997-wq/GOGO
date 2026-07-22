import 'dart:math';
import 'package:flutter/material.dart';

class FloatingHearts extends StatefulWidget {
  const FloatingHearts({
    super.key,
    this.count = 12,
    this.duration = const Duration(seconds: 4),
    this.size = 22,
  });

  final int count;
  final Duration duration;
  final double size;

  @override
  State<FloatingHearts> createState() =>
      _FloatingHeartsState();
}

class _FloatingHeartsState
    extends State<FloatingHearts>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _randomColor() {
    const colors = [
      Colors.red,
      Colors.pink,
      Colors.deepPurple,
      Colors.orange,
      Colors.purple,
    ];

    return colors[_random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: List.generate(
                  widget.count,
                  (index) {
                    final progress =
                        (_controller.value +
                                index /
                                    widget.count) %
                            1;

                    final x = (constraints.maxWidth *
                            ((index + 1) /
                                widget.count)) +
                        sin(progress * pi * 2) * 25;

                    final y =
                        constraints.maxHeight -
                            progress *
                                constraints.maxHeight;

                    return Positioned(
                      left: x,
                      top: y,
                      child: Opacity(
                        opacity: 1 - progress,
                        child: Transform.scale(
                          scale:
                              .6 + progress * .8,
                          child: Icon(
                            Icons.favorite,
                            color: _randomColor(),
                            size: widget.size,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}