import 'package:flutter/material.dart';

import 'entry_animation.dart';

class VipEntry extends StatelessWidget {
  const VipEntry({
    super.key,
    required this.username,
    this.level,
    this.avatar,
    this.width = 340,
    this.height = 120,
    this.onCompleted,
  });

  final String username;
  final int? level;
  final String? avatar;
  final double width;
  final double height;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return EntryAnimation(
      onCompleted: onCompleted,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [
              Color(0xffF7D774),
              Color(0xffD49C28),
              Color(0xff8C5A00),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 18),
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              backgroundImage: avatar != null
                  ? NetworkImage(avatar!)
                  : null,
              child: avatar == null
                  ? const Icon(
                      Icons.person,
                      color: Colors.black54,
                      size: 34,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VIP ENTRY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (level != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 4),
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: Text(
                          'LV.$level',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 18),
              child: Icon(
                Icons.workspace_premium,
                color: Colors.white,
                size: 42,
              ),
            ),
          ],
        ),
      ),
    );
  }
}