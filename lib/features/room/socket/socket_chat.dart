import 'dart:async';

import 'package:joojo_chat/features/room/socket/socket_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketChat {
  // تم استخدام الـ formal initializer لحل تحذير prefer_initializing_formals بالمليمتر
  SocketChat({required io.Socket? socket}) : _socket = socket;

  final io.Socket? _socket;

  // قنوات بث تيارية (Streams) مستقلة لبث الرسائل وحالة الكتابة للواجهات مباشرة
  final StreamController<Map<String, dynamic>> _messageController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;

  final StreamController<Map<String, dynamic>> _typingController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get typingStream => _typingController.stream;

  // تم حذف علامة التعجب الزائدة (!) في الفحص الوقائي لمنع تحذير unnecessary_non_null_assertion
  bool _isReady() => _socket != null && _socket.connected;

  // ==========================================
  // LISTENERS (المستمعين)
  // ==========================================

  // بدء الاستماع للأحداث الفورية القادمة من السيرفر الخاصة بالشات والمحادثة
  void initChatListeners() {
    if (_socket == null) return;

    // تم حذف علامات (!) الزائدة وتمرير (dynamic data) لمنع الـ Inference Failure
    _socket.on(SocketEvents.receiveMessage, (dynamic data) {
      if (data is Map<String, dynamic> && !_messageController.isClosed) {
        _messageController.add(data);
      }
    });

    _socket.on(SocketEvents.typingStatus, (dynamic data) {
      if (data is Map<String, dynamic> && !_typingController.isClosed) {
        _typingController.add(data);
      }
    });
  }

  // ==========================================
  // EMITTERS (إرسال الأحداث)
  // ==========================================

  // بث الرسالة النصية المكتوبة حالياً لبقية المتواجدين في الغرفة الصوتية فوراً
  void sendChatRoomMessage({
    required String roomId,
    required String userId,
    required String message,
  }) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.sendMessage, {
      'room_id': roomId,
      'user_id': userId,
      'message': message,
    });
  }

  // بث إشارة وميض مؤشر الكتابة "يكتب الآن..." أو إيقافه عند رفع الأصابع عن الكيبورد
  void sendTypingStatus({
    required String roomId,
    required String userId,
    required bool isTyping,
  }) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.typingStatus, {
      'room_id': roomId,
      'user_id': userId,
      'is_typing': isTyping,
    });
  }

  // ==========================================
  // CLEANUP (تفريغ الذاكرة)
  // ==========================================
  void dispose() {
    _messageController.close();
    _typingController.close();
  }
}
