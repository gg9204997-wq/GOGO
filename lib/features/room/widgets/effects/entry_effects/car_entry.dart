import 'package:flutter/material.dart';

import 'entry_animation.dart';

class CarEntry extends StatelessWidget {
  const CarEntry({
    super.key,
    required this.username,
    required this.carName,
    this.avatar,
    this.level,
    this.width = 420,
    this.height = 140,
    this.onCompleted,
  });

  final String username;
  final String carName;
  final String? avatar;
  final int? level;
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
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff24243E),
              Color(0xff302B63),
              Color(0xff0F0C29),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 25,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 18),

            CircleAvatar(
              radius: 34,
              backgroundColor: Colors.white,
              backgroundImage:
                  avatar != null ? NetworkImage(avatar!) : null,
              child: avatar == null
                  ? const Icon(
                      Icons.person,
                      size: 34,
                      color: Colors.black54,
                    )
                  : null,
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Luxury Car Entry",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
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

                  const SizedBox(height: 4),

                  Text(
                    carName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  if (level != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: Text(
                          "LV.$level",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.directions_car_filled_rounded,
                color: Colors.amber,
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}