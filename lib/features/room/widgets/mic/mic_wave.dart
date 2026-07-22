import 'package:flutter/material.dart';

class MicWave extends StatefulWidget {
  const MicWave({
    required this.size,
    super.key,
    this.color = Colors.greenAccent,
    this.duration = const Duration(milliseconds: 900),
  });

  final double size;
  final Color color;
  final Duration duration;

  @override
  State<MicWave> createState() => _MicWaveState();
}

class _MicWaveState extends State<MicWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: .85,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.color.withValues(alpha: .45),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: .20),
                  blurRadius: 18,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}