import 'package:flutter/material.dart';

import 'package:joojo_chat/core/theme/app_colors.dart';
import 'package:joojo_chat/core/theme/app_radius.dart';
import 'package:joojo_chat/core/theme/app_text_styles.dart';

class FloatingRoomWidget extends StatefulWidget {
  const FloatingRoomWidget({
    super.key,
  });

  @override
  State<FloatingRoomWidget> createState() =>
      _FloatingRoomWidgetState();
}

class _FloatingRoomWidgetState
    extends State<FloatingRoomWidget> {
  bool minimized = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      right: 16,
      bottom: 90,

      child: GestureDetector(
        onTap: () {
          setState(() {
            minimized = !minimized;
          });
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),

          width: minimized ? 74 : 270,
          height: minimized ? 74 : 95,

          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(70),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: minimized
              ? const Center(
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(
                      'assets/images/room_cover.jpg',
                    ),
                  ),
                )
              : Row(
                  children: [
                    const SizedBox(width: 12),

                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(
                        'assets/images/room_cover.jpg',
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'غرفة السهرة',
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: AppTextStyles.titleMedium
                                .copyWith(
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '356 عضو',
                            style: AppTextStyles.bodySmall
                                .copyWith(
                              color:
                                  Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}