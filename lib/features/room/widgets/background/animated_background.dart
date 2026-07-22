import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({
    super.key,
    this.child,
    this.background,
    this.overlayOpacity = .35,
  });

  final Widget? child;
  final String? background;
  final double overlayOpacity;

  @override
  State<AnimatedBackground> createState() =>
      _AnimatedBackgroundState();
}

class _AnimatedBackgroundState
    extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
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
        return Stack(
          fit: StackFit.expand,
          children: [
            if (widget.background != null &&
                widget.background!.isNotEmpty)
              Image.network(
                widget.background!,
                fit: BoxFit.cover,
              )
            else
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff131722),
                      Color(0xff1B2233),
                      Color(0xff252E45),
                    ],
                  ),
                ),
              ),

            Container(
              color: Colors.black.withOpacity(
                widget.overlayOpacity,
              ),
            ),

            ...List.generate(
              30,
              (index) {
                final value =
                    (_controller.value +
                            index / 30) %
                        1;

                return Positioned(
                  left: (_random.nextDouble() *
                          MediaQuery.of(context)
                              .size
                              .width),
                  top: MediaQuery.of(context)
                          .size
                          .height *
                      value,
                  child: Opacity(
                    opacity: .15,
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration:
                          const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
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
  }
}