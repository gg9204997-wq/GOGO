import 'dart:async';

import 'package:joojo_chat/features/room/socket/socket_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketAdmin {
  // تم استخدام الـ formal initializer لحل تحذير prefer_initializing_formals بالمليمتر
  SocketAdmin({required io.Socket? socket}) : _socket = socket;

  final io.Socket? _socket;

  // قناة بث تيارية موحدة (Stream) لضخ قرارات الإدارة الفورية وتحديث صلاحيات الـ UI
  final StreamController<Map<String, dynamic>> _adminActionController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get adminActionStream => _adminActionController.stream;

  // تم حذف علامة التعجب الزائدة (!) في الفحص الوقائي لمنع تحذير unnecessary_non_null_assertion
  bool _isReady() => _socket != null && _socket.connected;

  // ==========================================
  // LISTENERS (المستمعين)
  // ==========================================

  // بدء الاستماع لجميع قرارات الإشراف الصارمة القادمة من السيرفر
  void initAdminListeners() {
    if (_socket == null) return;

    // تم حذف علامات (!) الزائدة من الـ listeners مع تمرير (dynamic data) لحماية النوع كلياً
    _socket.on(SocketEvents.kickUser, (dynamic data) => _emitToStream(data, 'kick'));
    _socket.on(SocketEvents.banUser, (dynamic data) => _emitToStream(data, 'ban'));
    _socket.on(SocketEvents.muteSeat, (dynamic data) => _emitToStream(data, 'mute_seat'));
    _socket.on(SocketEvents.lockSeat, (dynamic data) => _emitToStream(data, 'lock_seat'));
  }

  // ميثود داخلي مخصص ومحمي لتوحيد ضخ الإجراءات الإدارية داخل الـ Stream
  void _emitToStream(dynamic data, String actionType) {
    if (data is Map<String, dynamic> && !_adminActionController.isClosed) {
      _adminActionController.add({
        'action_type': actionType,
        ...data,
      });
    }
  }

  // ==========================================
  // EMITTERS (إرسال الأحداث)
  // ==========================================

  // بث أوامر المشرفين والمسؤولين فورياً لجميع زوار الغرفة الصوتية
  void sendAdminAction({
    required String roomId,
    required String actionType, // 'kick', 'ban', 'mute_seat', 'lock_seat'
    required Map<String, dynamic> actionData,
  }) {
    if (!_isReady()) return;

    String eventName = SocketEvents.kickUser;
    if (actionType == 'ban') eventName = SocketEvents.banUser;
    if (actionType == 'mute_seat') eventName = SocketEvents.muteSeat;
    if (actionType == 'lock_seat') eventName = SocketEvents.lockSeat;

    _socket!.emit(eventName, {
      'room_id': roomId,
      ...actionData,
    });
  }

  // ==========================================
  // CLEANUP (تفريغ الذاكرة)
  // ==========================================
  void dispose() {
    _adminActionController.close();
  }
}
