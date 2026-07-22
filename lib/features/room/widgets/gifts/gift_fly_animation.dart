import 'package:flutter/material.dart';

class GiftFlyAnimation extends StatefulWidget {
  const GiftFlyAnimation({
    super.key,
    required this.child,
    this.begin = const Offset(0, 250),
    this.end = const Offset(0, -250),
    this.duration = const Duration(milliseconds: 1800),
    this.curve = Curves.easeOutCubic,
    this.fade = true,
    this.onCompleted,
  });

  final Widget child;
  final Offset begin;
  final Offset end;
  final Duration duration;
  final Curve curve;
  final bool fade;
  final VoidCallback? onCompleted;

  @override
  State<GiftFlyAnimation> createState() =>
      _GiftFlyAnimationState();
}

class _GiftFlyAnimationState
    extends State<GiftFlyAnimation>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  late final Animation<Offset> _position;

  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _position = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    _opacity = Tween<double>(
      begin: 1,
      end: widget.fade ? 0 : 1,
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
    Widget child = SlideTransition(
      position: _position,
      child: widget.child,
    );

    if (widget.fade) {
      child = FadeTransition(
        opacity: _opacity,
        child: child,
      );
    }

    return IgnorePointer(
      child: child,
    );
  }
}