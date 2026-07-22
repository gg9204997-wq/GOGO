import 'dart:async';

import 'package:joojo_chat/features/room/socket/socket_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketGifts {
  // تم استخدام التعيين البنائي المباشر للحقل لحل تحذير prefer_initializing_formals نهائياً وبلا تكرار
  SocketGifts({required io.Socket? socket}) : _socket = socket;

  final io.Socket? _socket;

  // قنوات بث تيارية (Streams) لبث إشعارات وتعداد الهدايا اللحظية للـ UI
  final StreamController<Map<String, dynamic>> _giftReceivedController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get giftReceivedStream => _giftReceivedController.stream;

  final StreamController<Map<String, dynamic>> _giftComboController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get giftComboStream => _giftComboController.stream;

  // فحص وقائي للتأكد من جاهزية اتصال السوكيت بالسيرفر
  bool _isReady() => _socket != null && _socket.connected;

  // ==========================================
  // LISTENERS (المستمعين)
  // ==========================================

  // بدء الاستماع للأحداث القادمة من السيرفر الخاصة بالهدايا
  void initGiftListeners() {
    if (_socket == null) return;

    _socket.on(SocketEvents.giftReceived, (dynamic data) {
      if (data is Map<String, dynamic> && !_giftReceivedController.isClosed) {
        _giftReceivedController.add(data);
      }
    });

    _socket.on(SocketEvents.giftComboUpdate, (dynamic data) {
      if (data is Map<String, dynamic> && !_giftComboController.isClosed) {
        _giftComboController.add(data);
      }
    });
  }

  // ==========================================
  // EMITTERS (إرسال الأحداث)
  // ==========================================

  // بث عداد ضغطات الهدايا المتتالية (الـ Combo Click) لتحديث الرقم والحجم لحظياً بالـ UI لبقية المتواجدين
  void sendGiftComboClick({
    required String roomId,
    required String giftId,
    required String senderId,
    required String receiverId,
    required int comboCount,
  }) {
    if (!_isReady()) return;
    
    // تم تصحيح الاستدعاء بإضافة (!) لمنع خطأ الـ Unchecked Use Of Nullable Value كلياً
    _socket!.emit(SocketEvents.sendGift, {
      'room_id': roomId,
      'gift_id': giftId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'combo_count': comboCount,
    });
  }

  // ==========================================
  // CLEANUP (تفريغ الذاكرة)
  // ==========================================
  void dispose() {
    _giftReceivedController.close();
    _giftComboController.close();
  }
}
