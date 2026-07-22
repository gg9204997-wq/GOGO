import 'dart:ui';

import 'package:flutter/material.dart';

class OnlineUsersSheet extends StatelessWidget {
  final List<OnlineUser> users;
  final ValueChanged<OnlineUser>? onUserTap;

  const OnlineUsersSheet({
    super.key,
    required this.users,
    this.onUserTap,
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
          height: MediaQuery.of(context).size.height * .75,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .55),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: .08),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                "المتواجدون (${users.length})",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  itemCount: users.length,
                  separatorBuilder: (_, __) => Divider(
                    color: Colors.white.withValues(alpha: .08),
                  ),
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => onUserTap?.call(user),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
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
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          user.name,
                                          overflow:
                                              TextOverflow.ellipsis,
                                          style:
                                              const TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                      if (user.vip)
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: Icon(
                                            Icons
                                                .workspace_premium,
                                            size: 16,
                                            color:
                                                Colors.amber,
                                          ),
                                        ),

                                      if (user.admin)
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: Icon(
                                            Icons.shield,
                                            size: 16,
                                            color: Colors
                                                .lightBlueAccent,
                                          ),
                                        ),
                                    ],
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "Lv.${user.level}",
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.circle,
                              color: Colors.greenAccent,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnlineUser {
  final String id;
  final String name;
  final String? avatar;
  final int level;
  final bool vip;
  final bool admin;

  const OnlineUser({
    required this.id,
    required this.name,
    this.avatar,
    this.level = 1,
    this.vip = false,
    this.admin = false,
  });
}