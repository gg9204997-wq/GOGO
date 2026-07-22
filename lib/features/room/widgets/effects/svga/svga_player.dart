import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SvgaPlayer extends StatelessWidget {
  const SvgaPlayer({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.repeat = false,
    this.onCompleted,
  });

  final String asset;
  final double? width;
  final double? height;
  final bool repeat;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Lottie.asset(
        asset,
        repeat: repeat,
        fit: BoxFit.contain,
        onLoaded: (composition) {
          if (!repeat && onCompleted != null) {
            Future.delayed(
              composition.duration,
              onCompleted!,
            );
          }
        },
      ),
    );
  }
}

class FullScreenSvga extends StatelessWidget {
  const FullScreenSvga({
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
        child: SvgaPlayer(
          asset: asset,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          onCompleted: onCompleted,
        ),
      ),
    );
  }
}