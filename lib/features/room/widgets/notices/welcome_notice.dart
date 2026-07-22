import 'dart:ui';

import 'package:flutter/material.dart';

class WelcomeNotice extends StatelessWidget {
  final String username;
  final String? avatar;
  final bool vip;
  final bool owner;
  final bool admin;
  final int level;

  const WelcomeNotice({
    super.key,
    required this.username,
    this.avatar,
    this.vip = false,
    this.owner = false,
    this.admin = false,
    this.level = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xff8A5CFF).withValues(alpha: .22),
                  const Color(0xff5B8CFF).withValues(alpha: .15),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: .08),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white10,
                  backgroundImage:
                      avatar != null ? NetworkImage(avatar!) : null,
                  child: avatar == null
                      ? const Icon(
                          Icons.person,
                          color: Colors.white70,
                        )
                      : null,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment:
                            WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              color: owner
                                  ? Colors.amber
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          if (vip)
                            const Icon(
                              Icons.workspace_premium,
                              color: Colors.amber,
                              size: 16,
                            ),

                          if (admin)
                            const Icon(
                              Icons.shield,
                              color: Colors.lightBlueAccent,
                              size: 16,
                            ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "مرحباً بك في الغرفة 🌸",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .80),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff8A5CFF),
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Lv.$level",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
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