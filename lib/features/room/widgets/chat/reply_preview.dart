import 'package:flutter/material.dart';
import '../../models/room_message_model.dart';

class ReplyPreview extends StatelessWidget {
  const ReplyPreview({
    super.key,
    required this.message,
    this.userName = '',
    this.onClose,
  });

  final RoomMessageModel message;
  final String userName;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff20263A),
        border: const Border(
          left: BorderSide(
            color: Colors.blue,
            width: 4,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.reply,
            color: Colors.blue,
            size: 20,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  userName.isEmpty
                      ? "Reply"
                      : userName,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  _preview(),
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onClose,
            splashRadius: 18,
            icon: const Icon(
              Icons.close,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  String _preview() {
    switch (message.type) {
      case 'image':
        return "📷 صورة";

      case 'gift':
        return "🎁 ${message.message}";

      case 'voice':
        return "🎤 رسالة صوتية";

      default:
        return message.message;
    }
  }
}