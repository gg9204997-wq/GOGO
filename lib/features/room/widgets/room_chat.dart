import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/room_message_model.dart';
import '../providers/room_message_provider.dart';
import '../providers/room_provider.dart';

import 'chat/chat_input.dart';
import 'chat/chat_list.dart';
import 'chat/pinned_message.dart';
import 'chat/reply_preview.dart';
import 'chat/scroll_to_bottom.dart';
import 'chat/typing_indicator.dart';
import 'chat/unread_badge.dart';

class RoomChat extends StatefulWidget {
  const RoomChat({
    super.key,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  final bool isExpanded;
  final VoidCallback onToggleExpand;

  @override
  State<RoomChat> createState() => _RoomChatState();
}

class _RoomChatState extends State<RoomChat> {
  final TextEditingController _messageController = TextEditingController();
  // 🟢 إضافة الـ Controller المسؤول عن تحريك الشات لأعلى ولأسفل برمجياً
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  RoomMessageModel? _replyMessage;
  RoomMessageModel? _pinnedMessage;

  bool _showUnreadBadge = false;
  bool _showScrollButton = false;
  bool _isFullyExpanded = false; // متابعة حالة السهم (لأعلى أم لأسفل)

  @override
  void initState() {
    super.initState();
    // مراقبة حجم الـ Sheet لتغيير اتجاه السهم تلقائياً أثناء السحب باليد
    _sheetController.addListener(() {
      if (_sheetController.size >= 0.90 && !_isFullyExpanded) {
        setState(() => _isFullyExpanded = true);
      } else if (_sheetController.size < 0.90 && _isFullyExpanded) {
        setState(() => _isFullyExpanded = false);
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final room = context.read<RoomProvider>().currentRoom;
    if (room == null) return;

    try {
      await context.read<RoomChatProvider>().sendRoomMessage(
            RoomMessageModel(
              id: '',
              roomId: room.id,
              sender: 'current_user',
              message: text,
              type: 'text',
              giftCount: 0,
              voiceDuration: 0,
              isDeleted: false,
              isSystem: false,
              edited: false,
              translated: false,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      _messageController.clear();
      if (mounted) {
        setState(() => _replyMessage = null);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل إرسال الرسالة\n$e')),
      );
    }
  }

  // دالة الضغط على السهم للتحكم في الصعود والنزول البرمجي الذكي
  void _toggleSheetPosition() {
    if (_isFullyExpanded) {
      _sheetController.animateTo(
        0.32, // العودة للمقاس المصغر أسفل المقاعد
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    } else {
      _sheetController.animateTo(
        0.95, // الصعود لتغطية الشاشة بالكامل
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _sheetController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final messages =
        context.watch<RoomChatProvider>().messages;

    return Align(
      alignment: Alignment.bottomCenter,
      child: DraggableScrollableSheet(
        // ربط الـ Controller الجديد لتمكين ميزة الضغط والسحب معاً دون تعارض
        controller: _sheetController,
        expand: false,
        initialChildSize: .32, 
        minChildSize: .14,
        maxChildSize: .95,
        snap: true,
        snapAnimationDuration:
            const Duration(milliseconds: 250),
        snapSizes: const [
          .14,
          .32,
          .70,
          .95,
        ],
        builder: (
          context,
          ScrollController listScrollController,
        ) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6B178A).withValues(alpha: 0.25),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 0,
                  sigmaY: 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(34, 17, 10, 36).withValues(alpha: 0.10),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: const Color.fromARGB(255, 230, 15, 183).withValues(alpha: 1),
                      width: 1.5,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 62),
                        child: Column(
                          children: [
                            if (_pinnedMessage != null)
                              PinnedMessage(
                                message: _pinnedMessage!,
                                userName: _pinnedMessage!.sender,
                                onUnpin: () => setState(() => _pinnedMessage = null),
                              ),

                            Expanded(
                              child: NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if (notification.metrics.pixels > 250) {
                                    if (!_showScrollButton) {
                                      setState(() => _showScrollButton = true);
                                    }
                                  } else {
                                    if (_showScrollButton) {
                                      setState(() => _showScrollButton = false);
                                    }
                                  }
                                  return false;
                                },
                                child: ChatList(
                                  // نمرر الـ listScrollController هنا ليظل السحب باليد شغالاً بكامل كفاءته
                                  controller: listScrollController,
                                  messages: messages,
                                  onReply: (message) => setState(() => _replyMessage = message),
                                  onLongPress: (message) => setState(() => _pinnedMessage = message),
                                ),
                              ),
                            ),

                            TypingIndicator(
                              visible: _messageController.text.isNotEmpty,
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: MediaQuery.of(context).padding.bottom,
                        child: ChatInput(
                          controller: _messageController,
                          onSend: _sendMessage,
                          onEmoji: () {},
                          onGift: () {},
                          onMic: () {},
                          onHeadset: () {},
                          onMore: () {},
                          replyPreview: _replyMessage == null
                              ? null
                              : ReplyPreview(
                                  message: _replyMessage!,
                                  userName: _replyMessage!.sender,
                                  onClose: () => setState(() => _replyMessage = null),
                                ),
                        ),
                      ),

                      // ═══ سهم الضغط التفاعلي المضيء بديل المقبض القديم ═══
                      Positioned(
                        top: 1,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: _toggleSheetPosition, // استدعاء دالة التحريك البرمجي عند الضغط
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 50,
                              height: 24,
                              alignment: Alignment.center,
                              color: Colors.transparent, // زيادة مساحة اللمس البرمجية المريحة للاصبع
                              child: Icon(
                                // يتغير اتجاه السهم تلقائياً (لأعلى أو لأسفل) بناءً على حجم الشات الحالي
                                _isFullyExpanded
                                    ? Icons.keyboard_arrow_down_rounded
                                    : Icons.keyboard_arrow_up_rounded,
                                color: Colors.white.withValues(alpha: 1),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),

                      if (_showUnreadBadge)
                        Positioned(
                          right: 18,
                          bottom: 82,
                          child: UnreadBadge(
                            count: 1,
                            onTap: () {
                              listScrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            },
                          ),
                        ),

                      if (_showScrollButton)
                        Positioned(
                          right: 18,
                          bottom: 82,
                          child: ScrollToBottom(
                            visible: _showScrollButton,
                            onPressed: () {
                              listScrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
