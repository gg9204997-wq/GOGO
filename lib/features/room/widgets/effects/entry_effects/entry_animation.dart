import 'package:flutter/material.dart';

class EntryAnimation extends StatefulWidget {
  const EntryAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1800),
    this.beginOffset = const Offset(1.2, 0),
    this.endOffset = Offset.zero,
    this.curve = Curves.easeOutBack,
    this.autoPlay = true,
    this.fade = true,
    this.scale = true,
    this.onCompleted,
  });

  final Widget child;

  final Duration duration;

  final Offset beginOffset;

  final Offset endOffset;

  final Curve curve;

  final bool autoPlay;

  final bool fade;

  final bool scale;

  final VoidCallback? onCompleted;

  @override
  State<EntryAnimation> createState() =>
      _EntryAnimationState();
}

class _EntryAnimationState
    extends State<EntryAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Offset> _slide;

  late final Animation<double> _opacity;

  late final Animation<double> _scale;

  bool _playing = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slide = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _scale = Tween<double>(
      begin: .85,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    if (widget.autoPlay) {
      play();
    }
  }

  Future<void> play() async {
    if (_playing) return;

    _playing = true;

    await _controller.forward();

    widget.onCompleted?.call();
  }

  Future<void> reverse() async {
    await _controller.reverse();
  }

  Future<void> reset() async {
    _controller.reset();
    _playing = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

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

    child = SlideTransition(
      position: _slide,
      child: child,
    );

    return RepaintBoundary(
      child: child,
    );
  }
}