import 'dart:async';

import 'package:joojo_chat/features/room/socket/socket_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketRoom {
  // تم استخدام الـ formal initializer لحل تحذير prefer_initializing_formals بالمليمتر
  SocketRoom({required io.Socket? socket}) : _socket = socket;

  final io.Socket? _socket;

  // قنوات بث تيارية (Streams) مستقلة ومخصصة لأحداث الغرفة لتغذية الـ Widgets مباشرة
  final StreamController<Map<String, dynamic>> _roomEventsController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get roomEventsStream => _roomEventsController.stream;

  final StreamController<Map<String, dynamic>> _speakingStatusController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get speakingStatusStream => _speakingStatusController.stream;

  // تم حذف علامة التعجب الزائدة (!) في الفحص الوقائي لمنع تحذير unnecessary_non_null_assertion
  bool _isReady() => _socket != null && _socket.connected;

  // ==========================================
  // LISTENERS (المستمعين)
  // ==========================================
  
  // بدء الاستماع للأحداث القادمة من السيرفر الخاصة بالغرفة والمايكات
  void initRoomListeners() {
    if (_socket == null) return;

    // تم حذف علامات (!) الزائدة من الـ listeners مع تمرير (dynamic data) لحماية النوع كلياً
    _socket.on(SocketEvents.userJoined, (dynamic data) {
      if (data is Map<String, dynamic> && !_roomEventsController.isClosed) {
        _roomEventsController.add({'event': 'joined', ...data});
      }
    });

    _socket.on(SocketEvents.userLeft, (dynamic data) {
      if (data is Map<String, dynamic> && !_roomEventsController.isClosed) {
        _roomEventsController.add({'event': 'left', ...data});
      }
    });

    _socket.on(SocketEvents.seatUpdate, (dynamic data) {
      if (data is Map<String, dynamic> && !_roomEventsController.isClosed) {
        _roomEventsController.add({'event': 'seat_updated', ...data});
      }
    });

    _socket.on(SocketEvents.speakingStatus, (dynamic data) {
      if (data is Map<String, dynamic> && !_speakingStatusController.isClosed) {
        _speakingStatusController.add(data);
      }
    });
  }

  // ==========================================
  // EMITTERS (إرسال الأحداث)
  // ==========================================

  // بث إشارة انضمام المستخدم الحالي لقناة الغرفة المفتوحة بالسيرفر
  void joinRoomChannel({required String roomId, required String userId, required String nickname}) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.joinRoom, {
      'room_id': roomId,
      'user_id': userId,
      'nickname': nickname,
    });
  }

  // بث إشارة مغادرة المستخدم الحالي لقناة الغرفة
  void leaveRoomChannel({required String roomId, required String userId}) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.leaveRoom, {
      'room_id': roomId,
      'user_id': userId,
    });
  }

  // بث التغير اللحظي لمستوى وذبذبات صوت المتحدث الحالي لبقية الزوار
  void sendSpeakingVolume({
    required String roomId,
    required int seatNumber,
    required bool isSpeaking,
    required int volume,
  }) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.speakingStatus, {
      'room_id': roomId,
      'seat_number': seatNumber,
      'is_speaking': isSpeaking,
      'volume': volume,
    });
  }

  // ==========================================
  // CLEANUP (تفريغ الذاكرة)
  // ==========================================
  void dispose() {
    _roomEventsController.close();
    _speakingStatusController.close();
  }
}
