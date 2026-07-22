import 'package:flutter/material.dart';

class SpeakingAnimation extends StatefulWidget {
  const SpeakingAnimation({
    required this.child,
    super.key,
    this.isSpeaking = true,
    this.duration = const Duration(milliseconds: 700),
    this.scale = 1.12,
  });

  final Widget child;
  final bool isSpeaking;
  final Duration duration;
  final double scale;

  @override
  State<SpeakingAnimation> createState() =>
      _SpeakingAnimationState();
}

class _SpeakingAnimationState
    extends State<SpeakingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: 1,
      end: widget.scale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isSpeaking) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(
    covariant SpeakingAnimation oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (widget.isSpeaking != oldWidget.isSpeaking) {
      if (widget.isSpeaking) {
        _controller.repeat(reverse: true);
      } else {
        _controller
          ..stop()
          ..reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isSpeaking) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}