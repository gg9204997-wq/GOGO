import 'package:flutter/material.dart';

class EntranceEffect extends StatefulWidget {
  const EntranceEffect({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
    this.offset = const Offset(0, .15),
    this.curve = Curves.easeOutCubic,
    this.fade = true,
    this.scale = false,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final Curve curve;
  final bool fade;
  final bool scale;

  @override
  State<EntranceEffect> createState() =>
      _EntranceEffectState();
}

class _EntranceEffectState
    extends State<EntranceEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;

  late final Animation<Offset> _slide;

  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animation);

    _slide = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(animation);

    _scale = Tween<double>(
      begin: .9,
      end: 1,
    ).animate(animation);

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
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
      position: _slide,
      child: widget.child,
    );

    if (widget.scale) {
      child = ScaleTransition(
        scale: _scale,
        child: child,
      );
    }

    if (widget.fade) {
      child = FadeTransition(
        opacity: _opacity,
        child: child,
      );
    }

    return child;
  }
}