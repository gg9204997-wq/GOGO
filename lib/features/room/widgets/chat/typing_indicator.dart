import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    this.userName = '',
    this.avatar,
    this.visible = true,
  });

  final String userName;
  final String? avatar;
  final bool visible;

  @override
  State<TypingIndicator> createState() =>
      _TypingIndicatorState();
}

class _TypingIndicatorState
    extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage:
                widget.avatar != null &&
                        widget.avatar!.isNotEmpty
                    ? NetworkImage(widget.avatar!)
                    : null,
            child: widget.avatar == null
                ? const Icon(
                    Icons.person,
                    size: 18,
                  )
                : null,
          ),

          const SizedBox(width: 10),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff2A3147),
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.userName.isEmpty
                      ? "يكتب..."
                      : "${widget.userName} يكتب...",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(width: 10),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Row(
                      children: List.generate(
                        3,
                        (index) {
                          final value =
                              ((_controller.value +
                                          index *
                                              .25) %
                                      1);

                          return Container(
                            margin:
                                const EdgeInsets.symmetric(
                              horizontal: 2,
                            ),
                            width: 6,
                            height:
                                6 + (value * 5),
                            decoration:
                                const BoxDecoration(
                              color: Colors.white,
                              shape:
                                  BoxShape.circle,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}