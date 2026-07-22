import 'package:flutter/material.dart';
import '../../models/room_message_model.dart';

class PinnedMessage extends StatelessWidget {
  const PinnedMessage({
    super.key,
    required this.message,
    this.userName = '',
    this.onTap,
    this.onUnpin,
  });

  final RoomMessageModel message;
  final String userName;
  final VoidCallback? onTap;
  final VoidCallback? onUnpin;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber.withOpacity(.12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.amber.withOpacity(.35),
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.push_pin,
                color: Colors.amber,
                size: 22,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName.isEmpty
                          ? "رسالة مثبتة"
                          : userName,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.amber,
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
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              if (onUnpin != null)
                IconButton(
                  onPressed: onUnpin,
                  splashRadius: 18,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white70,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _preview() {
    switch (message.type) {
      case 'image':
        return "📷 صورة";

      case 'voice':
        return "🎤 رسالة صوتية";

      case 'gift':
        return "🎁 ${message.message}";

      default:
        return message.message;
    }
  }
}