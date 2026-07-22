import 'package:flutter/material.dart';

class RoomHeaderParticles extends StatelessWidget {
  const RoomHeaderParticles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: const [
          _Particle(
            left: 18,
            top: 18,
            size: 3,
            color: Color(0xffFFD54F),
          ),
          _Particle(
            left: 45,
            top: 52,
            size: 2,
            color: Colors.white,
          ),
          _Particle(
            left: 120,
            top: 16,
            size: 4,
            color: Color(0xffFFD54F),
          ),
          _Particle(
            left: 185,
            top: 38,
            size: 2,
            color: Colors.white,
          ),
          _Particle(
            left: 260,
            top: 22,
            size: 3,
            color: Color(0xffFFD54F),
          ),
          _Particle(
            left: 315,
            top: 58,
            size: 2,
            color: Colors.white,
          ),
          _Particle(
            right: 28,
            top: 16,
            size: 4,
            color: Color(0xffFFD54F),
          ),
          _Particle(
            right: 75,
            top: 45,
            size: 2,
            color: Colors.white,
          ),
          _Particle(
            right: 130,
            bottom: 24,
            size: 3,
            color: Color(0xffFFD54F),
          ),
          _Particle(
            right: 42,
            bottom: 18,
            size: 2,
            color: Colors.white,
          ),
          _Particle(
            left: 150,
            bottom: 18,
            size: 2,
            color: Colors.white,
          ),
          _Particle(
            left: 85,
            bottom: 30,
            size: 3,
            color: Color(0xffFFD54F),
          ),
          _Sparkle(
            left: 72,
            top: 26,
          ),
          _Sparkle(
            right: 95,
            top: 18,
          ),
          _Sparkle(
            right: 55,
            bottom: 28,
          ),
          _Sparkle(
            left: 210,
            bottom: 18,
          ),
        ],
      ),
    );
  }
}

class _Particle extends StatelessWidget {
  const _Particle({
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.size,
    required this.color,
  });

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: .45),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Icon(
        Icons.auto_awesome,
        size: 12,
        color: const Color(0xffFFD54F).withValues(alpha: .85),
      ),
    );
  }
}