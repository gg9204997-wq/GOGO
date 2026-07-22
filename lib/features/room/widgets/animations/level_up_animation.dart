import 'package:flutter/material.dart';

class LevelUpAnimation extends StatefulWidget {
  const LevelUpAnimation({
    super.key,
    required this.level,
    this.duration = const Duration(seconds: 3),
    this.onFinished,
  });

  final int level;
  final Duration duration;
  final VoidCallback? onFinished;

  @override
  State<LevelUpAnimation> createState() =>
      _LevelUpAnimationState();
}

class _LevelUpAnimationState
    extends State<LevelUpAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _scale = Tween<double>(
      begin: .4,
      end: 1,
    ).animate(curve);

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    _rotation = Tween<double>(
      begin: -.15,
      end: 0,
    ).animate(curve);

    _controller.forward();

    Future.delayed(widget.duration, () async {
      if (!mounted) return;

      await _controller.reverse();

      widget.onFinished?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: FadeTransition(
          opacity: _fade,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Transform.rotate(
                angle: _rotation.value,
                child: Transform.scale(
                  scale: _scale.value,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 22,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(26),
                      gradient:
                          const LinearGradient(
                        colors: [
                          Color(0xffFFD54F),
                          Color(0xffFF9800),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange
                              .withOpacity(.45),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.workspace_premium,
                          size: 70,
                          color: Colors.white,
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          "LEVEL UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                            letterSpacing: 1.3,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "وصلت إلى المستوى ${widget.level}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius:
                                BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: Text(
                            "Lv.${widget.level}",
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}