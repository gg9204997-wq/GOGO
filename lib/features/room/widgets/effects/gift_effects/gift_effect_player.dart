import 'dart:async';

import 'package:flutter/material.dart';

class GiftEffectPlayer extends StatefulWidget {
  const GiftEffectPlayer({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.autoPlay = true,
    this.onCompleted,
  });

  final Widget child;
  final Duration duration;
  final bool autoPlay;
  final VoidCallback? onCompleted;

  @override
  State<GiftEffectPlayer> createState() => _GiftEffectPlayerState();
}

class _GiftEffectPlayerState extends State<GiftEffectPlayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fade;

  late final Animation<double> _scale;

  late final Animation<Offset> _slide;

  Timer? _timer;

  bool _visible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scale = Tween<double>(
      begin: .7,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, .2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    if (widget.autoPlay) {
      play();
    }
  }

  Future<void> play() async {
    if (_visible) return;

    setState(() {
      _visible = true;
    });

    await _controller.forward();

    _timer?.cancel();

    _timer = Timer(widget.duration, () async {
      await stop();
    });
  }

  Future<void> stop() async {
    await _controller.reverse();

    if (!mounted) return;

    setState(() {
      _visible = false;
    });

    widget.onCompleted?.call();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: RepaintBoundary(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: ScaleTransition(
              scale: _scale,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}