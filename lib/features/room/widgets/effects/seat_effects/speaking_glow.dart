import 'package:flutter/material.dart';

class SpeakingGlow extends StatefulWidget {
  const SpeakingGlow({
    super.key,
    required this.child,
    this.isSpeaking = true,
    this.color = const Color(0xFF42A5F5),
    this.size = 90,
    this.duration = const Duration(milliseconds: 900),
  });

  final Widget child;
  final bool isSpeaking;
  final Color color;
  final double size;
  final Duration duration;

  @override
  State<SpeakingGlow> createState() => _SpeakingGlowState();
}

class _SpeakingGlowState extends State<SpeakingGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.isSpeaking) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant SpeakingGlow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isSpeaking && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }

    if (!widget.isSpeaking && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
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
      builder: (_, child) {
        final glow =
            widget.isSpeaking ? (_controller.value * 18) : 0.0;

        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(
                  widget.isSpeaking
                      ? 0.35 + (_controller.value * .35)
                      : 0,
                ),
                blurRadius: glow,
                spreadRadius: glow / 3,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}