import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final int level;
  final bool isVip;
  final bool isOwner;
  final bool isModerator;
  final bool isOnline;
  final bool isSpeaking;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    required this.imageUrl,
    this.size = 56,
    this.level = 1,
    this.isVip = false,
    this.isOwner = false,
    this.isModerator = false,
    this.isOnline = true,
    this.isSpeaking = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = _borderColor();

    return InkWell(
      borderRadius: BorderRadius.circular(size),
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: borderColor.withValues(alpha: .35),
                  blurRadius: isSpeaking ? 18 : 10,
                  spreadRadius: isSpeaking ? 3 : 1,
                ),
              ],
            ),
            child: ClipOval(
              child: imageUrl.isEmpty
                  ? Container(
                      color: const Color(0xff2A233A),
                      child: Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: size * .45,
                      ),
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: const Color(0xff2A233A),
                          child: Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: size * .45,
                          ),
                        );
                      },
                    ),
            ),
          ),

          if (isVip)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),

          if (isOwner)
            Positioned(
              left: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star,
                  size: 11,
                  color: Colors.white,
                ),
              ),
            ),

          if (isModerator)
            Positioned(
              left: -2,
              bottom: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield,
                  size: 11,
                  color: Colors.white,
                ),
              ),
            ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: isOnline ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xff1B1629),
                  width: 2,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _levelColors(),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Lv.$level",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _borderColor() {
    if (isOwner) return Colors.orange;
    if (isModerator) return Colors.lightBlueAccent;
    if (isVip) return Colors.amber;

    if (level >= 100) return Colors.amber;
    if (level >= 70) return Colors.purpleAccent;
    if (level >= 40) return Colors.blueAccent;
    if (level >= 20) return Colors.greenAccent;

    return Colors.white24;
  }

  List<Color> _levelColors() {
    if (level >= 100) {
      return const [
        Color(0xffFFD700),
        Color(0xffFF9800),
      ];
    }

    if (level >= 70) {
      return const [
        Color(0xffA855F7),
        Color(0xff7E22CE),
      ];
    }

    if (level >= 40) {
      return const [
        Color(0xff3B82F6),
        Color(0xff2563EB),
      ];
    }

    if (level >= 20) {
      return const [
        Color(0xff10B981),
        Color(0xff059669),
      ];
    }

    return const [
      Color(0xff6B7280),
      Color(0xff4B5563),
    ];
  }
}