import 'dart:ui';

import 'package:flutter/material.dart';

class TopGifters extends StatelessWidget {
  final List<TopGifterModel> users;
  final ValueChanged<TopGifterModel>? onTap;

  const TopGifters({
    super.key,
    required this.users,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .35),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withValues(alpha: .08),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 14),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.card_giftcard,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "أفضل الداعمين",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                separatorBuilder: (_, __) => Divider(
                  color: Colors.white.withValues(alpha: .08),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final user = users[index];

                  return InkWell(
                    onTap: () => onTap?.call(user),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: Text(
                              "#${index + 1}",
                              style: TextStyle(
                                color: index == 0
                                    ? Colors.amber
                                    : Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white10,
                            backgroundImage: user.avatar != null
                                ? NetworkImage(user.avatar!)
                                : null,
                            child: user.avatar == null
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
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${user.coins} Coins",
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.workspace_premium,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopGifterModel {
  final String id;
  final String name;
  final String? avatar;
  final int coins;

  const TopGifterModel({
    required this.id,
    required this.name,
    this.avatar,
    required this.coins,
  });
}