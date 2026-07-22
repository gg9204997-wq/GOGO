import 'package:flutter/material.dart';

import 'gift_effect_player.dart';

class FullscreenGift extends StatelessWidget {
  const FullscreenGift({
    super.key,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.dismissible = false,
    this.onCompleted,
  });

  final Widget child;

  final Color backgroundColor;

  final bool dismissible;

  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    Widget content = Material(
      color: backgroundColor,
      child: SafeArea(
        child: Center(
          child: GiftEffectPlayer(
            onCompleted: onCompleted,
            child: child,
          ),
        ),
      ),
    );

    if (dismissible) {
      content = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onCompleted,
        child: content,
      );
    }

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !dismissible,
        child: content,
      ),
    );
  }

  static OverlayEntry show({
    required BuildContext context,
    required Widget child,
    Color backgroundColor = Colors.transparent,
    bool dismissible = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) {
        return FullscreenGift(
          backgroundColor: backgroundColor,
          dismissible: dismissible,
          onCompleted: () {
            entry.remove();
          },
          child: GiftEffectPlayer(
            duration: duration,
            onCompleted: () {
              entry.remove();
            },
            child: child,
          ),
        );
      },
    );

    Overlay.of(context).insert(entry);

    return entry;
  }
}