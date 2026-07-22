import 'dart:math';
import 'package:flutter/material.dart';

class SparkleBackground extends StatefulWidget {
  const SparkleBackground({
    super.key,
    this.count = 45,
    this.color = Colors.white,
    this.duration = const Duration(seconds: 8),
    this.child,
  });

  final int count;
  final Color color;
  final Duration duration;
  final Widget? child;

  @override
  State<SparkleBackground> createState() =>
      _SparkleBackgroundState();
}

class _SparkleBackgroundState
    extends State<SparkleBackground>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                ...List.generate(
                  widget.count,
                  (index) {
                    final seed = index * 37;

                    final x =
                        ((seed * 19) %
                                constraints.maxWidth
                                    .toInt())
                            .toDouble();

                    final baseY =
                        ((seed * 31) %
                                constraints.maxHeight
                                    .toInt())
                            .toDouble();

                    final offset =
                        sin((_controller.value * 2 * pi) +
                                index) *
                            20;

                    final size =
                        2.0 +
                            (index % 4).toDouble();

                    final opacity =
                        (.25 +
                                (.75 *
                                    (sin((_controller.value *
                                                    2 *
                                                    pi) +
                                                index)
                                            .abs())))
                            .clamp(0.0, 1.0);

                    return Positioned(
                      left: x,
                      top: baseY + offset,
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.rotate(
                          angle:
                              _controller.value *
                                  pi *
                                  2,
                          child: Icon(
                            Icons.auto_awesome,
                            color: widget.color,
                            size: size * 4,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                if (widget.child != null)
                  widget.child!,
              ],
            );
          },
        );
      },
    );
  }
}