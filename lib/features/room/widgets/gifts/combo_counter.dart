import 'package:flutter/material.dart';

class ComboCounter extends StatefulWidget {
  const ComboCounter({
    super.key,
    required this.count,
    this.duration = const Duration(milliseconds: 350),
    this.backgroundColor = const Color(0xFF7C3AED),
    this.textColor = Colors.white,
    this.iconColor = Colors.amber,
  });

  final int count;
  final Duration duration;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  @override
  State<ComboCounter> createState() => _ComboCounterState();
}

class _ComboCounterState extends State<ComboCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  int _lastValue = 0;

  @override
  void initState() {
    super.initState();

    _lastValue = widget.count;

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scale = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ComboCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.count != _lastValue) {
      _lastValue = widget.count;

      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: widget.backgroundColor.withOpacity(.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_fire_department,
              color: widget.iconColor,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              "x${widget.count}",
              style: TextStyle(
                color: widget.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}