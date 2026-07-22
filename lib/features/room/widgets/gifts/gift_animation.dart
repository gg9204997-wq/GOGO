import 'package:flutter/material.dart';

class GiftAnimation extends StatefulWidget {
  const GiftAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.scale = 1.25,
    this.onCompleted,
  });

  final Widget child;
  final Duration duration;
  final double scale;
  final VoidCallback? onCompleted;

  @override
  State<GiftAnimation> createState() => _GiftAnimationState();
}

class _GiftAnimationState extends State<GiftAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scale = Tween<double>(
      begin: 0.4,
      end: widget.scale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.forward().whenComplete(() {
      widget.onCompleted?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}