import 'package:flutter/material.dart';

class ComboEffect extends StatefulWidget {
  const ComboEffect({
    super.key,
    required this.combo,
    this.duration = const Duration(seconds: 2),
    this.color = Colors.orange,
    this.onCompleted,
  });

  final int combo;
  final Duration duration;
  final Color color;
  final VoidCallback? onCompleted;

  @override
  State<ComboEffect> createState() => _ComboEffectState();
}

class _ComboEffectState extends State<ComboEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scale;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scale = Tween<double>(
      begin: .5,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
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

    _offset = Tween<Offset>(
      begin: const Offset(0, .3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _play();
  }

  Future<void> _play() async {
    await _controller.forward();

    await Future.delayed(
      const Duration(milliseconds: 900),
    );

    if (!mounted) return;

    await _controller.reverse();

    widget.onCompleted?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.55),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: widget.color,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(.45),
            blurRadius: 20,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            color: widget.color,
            size: 28,
          ),
          const SizedBox(width: 8),
          Text(
            'Combo ×${widget.combo}',
            style: TextStyle(
              color: widget.color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _offset,
          child: ScaleTransition(
            scale: _scale,
            child: RepaintBoundary(
              child: _buildCounter(),
            ),
          ),
        ),
      ),
    );
  }
}