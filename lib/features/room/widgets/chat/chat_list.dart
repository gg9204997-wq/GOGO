import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:joojo_chat/features/room/models/room_message_model.dart';
import 'package:joojo_chat/features/room/widgets/chat/message_bubble.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
    required this.messages,
    required this.onReply,
    required this.onLongPress,
    this.controller,
  });

  final List<RoomMessageModel> messages;
  final ScrollController? controller;
  final void Function(RoomMessageModel) onReply;
  final void Function(RoomMessageModel) onLongPress;

  @override
  Widget build(BuildContext context) {
    // إزالة شرط الإرجاع المنفصل وجعل الـ _EmptyChat جزءاً من السحب
    return CustomScrollView(
      controller: controller,
      // 🟢 هذا السطر يجبر الشاشة على السحب حتى لو كانت فارغة تماماً
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      slivers: [
        if (messages.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: const Center(
              child: _EmptyChat(),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 14, 8, 16),
            sliver: SliverList.separated(
              itemCount: messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];

                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onLongPress: () => onLongPress(message),
                  child: MessageBubble(
                    key: ValueKey(message.id),
                    message: message,
                    onReply: () => onReply(message),
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 220))
                      .slideY(
                        begin: .18,
                        end: 0,
                        curve: Curves.easeOutCubic,
                      ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _EmptyChat extends StatelessWidget {
  const _EmptyChat();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .04),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: .04),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: Colors.white38,
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            "ابدأ أول رسالة داخل الغرفة",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}
