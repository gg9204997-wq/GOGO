import 'package:flutter/material.dart';

class ScrollToBottom extends StatelessWidget {
  const ScrollToBottom({
    super.key,
    required this.visible,
    required this.onPressed,
    this.unreadCount = 0,
  });

  final bool visible;
  final VoidCallback onPressed;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 250),
        child: AnimatedSlide(
          offset: visible
              ? Offset.zero
              : const Offset(0, 1),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: FloatingActionButton.small(
            heroTag: "scroll_to_bottom",
            backgroundColor: const Color(0xff4F6BFF),
            elevation: 8,
            onPressed: onPressed,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Center(
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                if (unreadCount > 0)
                  Positioned(
                    top: -6,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        unreadCount > 99
                            ? "99+"
                            : unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}