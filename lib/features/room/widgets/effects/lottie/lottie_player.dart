import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePlayer extends StatefulWidget {
  const LottiePlayer({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.repeat = true,
    this.animate = true,
    this.reverse = false,
    this.controller,
    this.onLoaded,
    this.onCompleted,
  });

  final String asset;

  final double? width;
  final double? height;

  final BoxFit fit;

  final bool repeat;
  final bool animate;
  final bool reverse;

  final AnimationController? controller;

  final ValueChanged<LottieComposition>? onLoaded;

  final VoidCallback? onCompleted;

  @override
  State<LottiePlayer> createState() =>
      _LottiePlayerState();
}

class _LottiePlayerState
    extends State<LottiePlayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool get _external =>
      widget.controller != null;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(vsync: this);
  }

  @override
  void dispose() {
    if (!_external) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Lottie.asset(
        widget.asset,
        controller: _controller,
        fit: widget.fit,
        repeat: widget.repeat,
        animate: widget.animate,
        reverse: widget.reverse,
        onLoaded: (composition) {
          widget.onLoaded?.call(composition);

          _controller
            ..duration = composition.duration
            ..forward();

          if (!widget.repeat) {
            _controller.addStatusListener((status) {
              if (status ==
                  AnimationStatus.completed) {
                widget.onCompleted?.call();
              }
            });
          }
        },
      ),
    );
  }
}

class FullScreenLottie extends StatelessWidget {
  const FullScreenLottie({
    super.key,
    required this.asset,
    this.onCompleted,
  });

  final String asset;

  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: LottiePlayer(
          asset: asset,
          width:
              MediaQuery.of(context).size.width,
          height:
              MediaQuery.of(context).size.height,
          repeat: false,
          onCompleted: onCompleted,
        ),
      ),
    );
  }
}