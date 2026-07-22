import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:joojo_chat/features/room/models/room_message_model.dart';
import 'package:joojo_chat/features/room/widgets/chat/chat_constants.dart';

enum ChatMenuAction {
  reply,
  copy,
  pin,
  edit,
  delete,
  report,
}

class ChatContextMenu extends StatelessWidget {
  const ChatContextMenu({
    required this.message,
    super.key,
    this.canEdit = false,
    this.canDelete = false,
    this.canPin = false,
    this.onSelected,
  });

  final RoomMessageModel message;

  final bool canEdit;
  final bool canDelete;
  final bool canPin;

  final ValueChanged<ChatMenuAction>? onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 18,
            sigmaY: 18,
          ),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1B2236).withValues(alpha: .94),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: .08),
              ),
              boxShadow: ChatConstants.cardShadow,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),

                  Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: ChatConstants.glassCard(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.sender,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            message.message,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  _item(
                    context,
                    Icons.reply_rounded,
                    'رد',
                    ChatMenuAction.reply,
                  ),

                  _divider(),

                  _item(
                    context,
                    Icons.copy_rounded,
                    'نسخ الرسالة',
                    ChatMenuAction.copy,
                  ),

                  if (canPin) ...[
                    _divider(),
                    _item(
                      context,
                      Icons.push_pin_rounded,
                      'تثبيت الرسالة',
                      ChatMenuAction.pin,
                      color: ChatConstants.warning,
                    ),
                  ],

                  if (canEdit) ...[
                    _divider(),
                    _item(
                      context,
                      Icons.edit_rounded,
                      'تعديل',
                      ChatMenuAction.edit,
                      color: Colors.lightBlueAccent,
                    ),
                  ],

                  if (canDelete) ...[
                    _divider(),
                    _item(
                      context,
                      Icons.delete_outline_rounded,
                      'حذف',
                      ChatMenuAction.delete,
                      color: ChatConstants.error,
                    ),
                  ],                  _divider(),

                  _item(
                    context,
                    Icons.flag_outlined,
                    'إبلاغ',
                    ChatMenuAction.report,
                    color: Colors.orange,
                  ),

                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: .6,
      color: Colors.white.withValues(alpha: .06),
      indent: 18,
      endIndent: 18,
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    ChatMenuAction action, {
    Color color = Colors.white,
  }) {
    final isRtl =
        Directionality.of(context) == TextDirection.rtl;

    return Semantics(
      button: true,
      label: title,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          splashColor: color.withValues(alpha: .08),
          highlightColor: color.withValues(alpha: .05),
          onTap: () {
            HapticFeedback.lightImpact();
            onSelected?.call(action);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 15,
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Icon(
                  isRtl
                      ? Icons.chevron_left_rounded
                      : Icons.chevron_right_rounded,
                  color: Colors.white.withValues(alpha: .35),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<ChatMenuAction?> show(
    BuildContext context, {
    required RoomMessageModel message,
    bool canEdit = false,
    bool canDelete = false,
    bool canPin = false,
  }) {
    return showModalBottomSheet<ChatMenuAction>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        return ChatContextMenu(
          message: message,
          canEdit: canEdit,
          canDelete: canDelete,
          canPin: canPin,
          onSelected: (action) {
            Navigator.of(sheetContext).pop(action);
          },
        );
      },
    );
  }
}