import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../models/room_message_model.dart';
import 'chat_constants.dart';
import 'message_time.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    this.isMe = false,
    this.userName = '',
    this.level = 1,
    this.avatar,
    this.isVip = false,
    this.isOwner = false,
    this.isModerator = false,
    this.badge,
    this.onReply,
  });

  final RoomMessageModel message;

  final bool isMe;

  final String userName;

  final int level;

  final String? avatar;

  final bool isVip;

  final bool isOwner;

  final bool isModerator;

  final String? badge;

  final VoidCallback? onReply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            _avatar(),
            const SizedBox(width: 10),
          ],

          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isMe) _header(),

                _bubble()
                    .animate()
                    .fadeIn(
                      duration:
                          const Duration(milliseconds: 180),
                    )
                    .slideY(
                      begin: .15,
                    ),

                const SizedBox(height: 4),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MessageTime(
                      date: message.createdAt,
                    ),

                    if (message.edited)
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 6),
                        child: Text(
                          "تم التعديل",
                          style: TextStyle(
                            color: Colors.white
                                .withValues(alpha: .45),
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          if (isMe) ...[
            const SizedBox(width: 10),
            _avatar(),
          ],
        ],
      ),
    );
  }

  Widget _avatar() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isVip
            ? ChatConstants.vipGradient
            : const LinearGradient(
                colors: [
                  Color(0xff5C6274),
                  Color(0xff363C4E),
                ],
              ),
        boxShadow: [
          BoxShadow(
            color: (isVip
                    ? ChatConstants.vip
                    : Colors.black)
                .withValues(alpha: .35),
            blurRadius: 14,
          ),
        ],
      ),
      padding: const EdgeInsets.all(2),
      child: CircleAvatar(
        backgroundColor: Colors.black,
        backgroundImage:
            avatar != null && avatar!.isNotEmpty
                ? NetworkImage(avatar!)
                : null,
        child: avatar == null || avatar!.isEmpty
            ? const Icon(
                Icons.person,
                color: Colors.white,
                size: 18,
              )
            : null,
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
        left: 2,
      ),
      child: Wrap(
        spacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            userName.isEmpty ? "مستخدم" : userName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),

          _level(),

          if (isVip) _vip(),

          if (isOwner) _owner(),

          if (isModerator) _moderator(),

          if (badge != null) _badge(),
        ],
      ),
    );
  }  Widget _bubble() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 310,
        minWidth: 70,
      ),
      decoration: ChatConstants.bubbleDecoration(
        mine: isMe,
      ),
      padding: ChatConstants.bubblePadding,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (message.replyTo != null &&
              message.replyTo!.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(
                bottom: 8,
              ),
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(
                  alpha: .18,
                ),
                borderRadius:
                    BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: .05,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 34,
                    decoration: BoxDecoration(
                      color: ChatConstants.primary,
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "رد على رسالة",
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white
                            .withValues(
                          alpha: .70,
                        ),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          _buildContent(),

          if (onReply != null)
            Padding(
              padding:
                  const EdgeInsets.only(top: 10),
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(20),
                onTap: onReply,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.reply,
                        size: 15,
                        color: Colors.white
                            .withValues(
                          alpha: .65,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "رد",
                        style: TextStyle(
                          color: Colors.white
                              .withValues(
                            alpha: .65,
                          ),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (message.type) {
      case "image":
        return ClipRRect(
          borderRadius:
              BorderRadius.circular(14),
          child: Image.network(
            message.image ?? "",
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) =>
                    const SizedBox.shrink(),
          ),
        );

      case "text":
      default:
        return SelectableText(
          message.message,
          style: ChatConstants.messageStyle,
        );
    }
  }  Widget _buildGiftMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: ChatConstants.giftGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.card_giftcard_rounded,
            color: Colors.amber,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          if (message.giftCount > 1)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "×${message.giftCount}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVoiceMessage() {
    return SizedBox(
      width: 220,
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: .12),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: .35,
                minHeight: 6,
                backgroundColor:
                    Colors.white.withValues(alpha: .08),
                valueColor:
                    const AlwaysStoppedAnimation(
                  Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          Text(
            "${message.voiceDuration}s",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: ChatConstants.systemGradient,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.amber,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _level() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        gradient: ChatConstants.vipGradient,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        "Lv.$level",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _vip() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        gradient: ChatConstants.vipGradient,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        "VIP",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _owner() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        gradient: ChatConstants.ownerGradient,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        "OWNER",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _moderator() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        gradient: ChatConstants.adminGradient,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        "MOD",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _badge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withValues(alpha: .08),
        ),
      ),
      child: Text(
        badge!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}