import 'dart:ui';

import 'package:flutter/material.dart';

class UserProfileSheet extends StatelessWidget {
  final String username;
  final String? avatar;
  final int level;
  final String id;
  final bool vip;
  final bool admin;
  final bool owner;

  final VoidCallback? onFollow;
  final VoidCallback? onMessage;
  final VoidCallback? onGift;
  final VoidCallback? onMention;
  final VoidCallback? onMute;
  final VoidCallback? onKick;
  final VoidCallback? onBan;

  const UserProfileSheet({
    super.key,
    required this.username,
    required this.id,
    this.avatar,
    this.level = 1,
    this.vip = false,
    this.admin = false,
    this.owner = false,
    this.onFollow,
    this.onMessage,
    this.onGift,
    this.onMention,
    this.onMute,
    this.onKick,
    this.onBan,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(28),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .55),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: .08),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 20),

                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white10,
                  backgroundImage:
                      avatar != null ? NetworkImage(avatar!) : null,
                  child: avatar == null
                      ? const Icon(
                          Icons.person,
                          color: Colors.white70,
                          size: 40,
                        )
                      : null,
                ),

                const SizedBox(height: 14),

                Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "ID : $id",
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  children: [
                    _badge(
                      Icons.star,
                      "Lv.$level",
                      Colors.orange,
                    ),

                    if (vip)
                      _badge(
                        Icons.workspace_premium,
                        "VIP",
                        Colors.amber,
                      ),

                    if (admin)
                      _badge(
                        Icons.shield,
                        "ADMIN",
                        Colors.lightBlue,
                      ),

                    if (owner)
                      _badge(
                        Icons.emoji_events,
                        "OWNER",
                        Colors.purpleAccent,
                      ),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: _button(
                        Icons.person_add,
                        "متابعة",
                        onFollow,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _button(
                        Icons.chat_bubble_outline,
                        "رسالة",
                        onMessage,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _button(
                        Icons.card_giftcard,
                        "هدية",
                        onGift,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _button(
                        Icons.alternate_email,
                        "منشن",
                        onMention,
                      ),
                    ),
                  ],
                ),

                if (admin || owner) ...[
                  const SizedBox(height: 20),

                  const Divider(color: Colors.white12),

                  ListTile(
                    leading: const Icon(
                      Icons.volume_off,
                      color: Colors.orange,
                    ),
                    title: const Text(
                      "كتم المستخدم",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: onMute,
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.redAccent,
                    ),
                    title: const Text(
                      "طرد من الغرفة",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: onKick,
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.block,
                      color: Colors.red,
                    ),
                    title: const Text(
                      "حظر المستخدم",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: onBan,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _badge(
    IconData icon,
    String text,
    Color color,
  ) {
    return Chip(
      avatar: Icon(
        icon,
        color: color,
        size: 16,
      ),
      label: Text(text),
      backgroundColor: Colors.white10,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _button(
    IconData icon,
    String text,
    VoidCallback? onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(46),
        backgroundColor: const Color(0xff8A5CFF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}