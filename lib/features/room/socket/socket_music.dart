import 'dart:async';

import 'package:joojo_chat/features/room/socket/socket_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketMusic {
  // تم استخدام التمرير المباشر لحل تحذير prefer_initializing_formals بالمليمتر
  SocketMusic({required io.Socket? socket}) : _socket = socket;

  final io.Socket? _socket;

  // قناة بث تيارية موحدة (Stream) لضخ أحداث الموسيقى الحية وتحديث الـ Music Player Bars بالـ UI
  final StreamController<Map<String, dynamic>> _musicEventController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get musicEventStream => _musicEventController.stream;

  // تم حذف علامة التعجب الزائدة (!) في الفحص الوقائي لمنع تحذير unnecessary_non_null_assertion
  bool _isReady() => _socket != null && _socket.connected;

  // ==========================================
  // LISTENERS (المستمعين)
  // ==========================================

  // بدء الاستماع لجميع أحداث مزامنة الأغاني والموسيقى القادمة من السيرفر
  void initMusicListeners() {
    if (_socket == null) return;

    _socket.on(SocketEvents.musicPlay, (dynamic data) => _emitToStream(data, 'play'));
    _socket.on(SocketEvents.musicPause, (dynamic data) => _emitToStream(data, 'pause'));
    _socket.on(SocketEvents.musicSeek, (dynamic data) => _emitToStream(data, 'seek'));
    _socket.on(SocketEvents.musicSync, (dynamic data) => _emitToStream(data, 'sync'));
  }

  // ميثود داخلي مخصص ومحمي لتوحيد ضخ أحداث الموسيقى داخل الـ Stream
  void _emitToStream(dynamic data, String actionType) {
    if (data is Map<String, dynamic> && !_musicEventController.isClosed) {
      _musicEventController.add({
        'action': actionType,
        ...data,
      });
    }
  }

  // ==========================================
  // EMITTERS (إرسال الأحداث)
  // ==========================================

  // بث إشارة التحكم بالموسيقى والوقت الحالي (Position) من طرف مالك الغرفة أو المتحكم بالمشغل
  void sendMusicControl({
    required String roomId,
    required String trackId,
    required String action, // 'play', 'pause', 'seek', 'sync'
    required int positionInSeconds,
  }) {
    if (!_isReady()) return;

    String eventName = SocketEvents.musicSync;
    if (action == 'play') eventName = SocketEvents.musicPlay;
    if (action == 'pause') eventName = SocketEvents.musicPause;
    if (action == 'seek') eventName = SocketEvents.musicSeek;

    _socket!.emit(eventName, {
      'room_id': roomId,
      'track_id': trackId,
      'position': positionInSeconds,
    });
  }

  // ==========================================
  // CLEANUP (تفريغ الذاكرة)
  // ==========================================
  void dispose() {
    _musicEventController.close();
  }
}
