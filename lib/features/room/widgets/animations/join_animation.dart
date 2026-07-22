import 'package:flutter/material.dart';

class JoinAnimation extends StatefulWidget {
  const JoinAnimation({
    super.key,
    required this.userName,
    this.avatar,
    this.duration = const Duration(seconds: 3),
    this.onFinished,
  });

  final String userName;
  final String? avatar;
  final Duration duration;
  final VoidCallback? onFinished;

  @override
  State<JoinAnimation> createState() =>
      _JoinAnimationState();
}

class _JoinAnimationState
    extends State<JoinAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Offset> _slide;

  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _slide = Tween<Offset>(
      begin: const Offset(-1.2, 0),
      end: Offset.zero,
    ).animate(curve);

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (!mounted) return;

      _controller.reverse().then((_) {
        widget.onFinished?.call();
      });
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
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(30),
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xff6C63FF),
                      Color(0xff3A86FF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue
                          .withOpacity(.35),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage:
                          widget.avatar !=
                                      null &&
                                  widget.avatar!
                                      .isNotEmpty
                              ? NetworkImage(
                                  widget.avatar!,
                                )
                              : null,
                      child: widget.avatar ==
                                  null ||
                              widget.avatar!
                                  .isEmpty
                          ? const Icon(
                              Icons.person,
                            )
                          : null,
                    ),

                    const SizedBox(width: 12),

                    Flexible(
                      child: RichText(
                        overflow:
                            TextOverflow
                                .ellipsis,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "🎉 ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text:
                                  widget.userName,
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 15,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  " دخل الغرفة",
                              style:
                                  TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}