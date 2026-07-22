import 'dart:async';

import 'package:joojo_chat/features/room/socket/socket_events.dart';
// تم تصحيح الامتداد بإضافة (.dart) في النهاية لحل خطأ الـ URI فوراً
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketListener {
  // تم استخدام (this._socket) مباشرة لإنهاء تنبيه prefer_initializing_formals كلياً
  SocketListener({required io.Socket? socket}) : _socket = socket;

  final io.Socket? _socket;

  // ==========================================
  // قنوات البث الحية (Stream Controllers)
  // ==========================================
  
  // البث الفوري لإشارات ووميض التحدث على المايك ومستويات الصوت
  final StreamController<Map<String, dynamic>> _speakingStreamController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get speakingStream => _speakingStreamController.stream;

  // البث الفوري لحركات دخول وخروج ومزامنة المقاعد الصوتية
  final StreamController<Map<String, dynamic>> _roomStreamController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get roomStream => _roomStreamController.stream;

  // البث الفوري لرسائل الشات اللحظية ومؤشر "يكتب الآن..."
  final StreamController<Map<String, dynamic>> _chatStreamController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get chatStream => _chatStreamController.stream;

  // البث الفوري لعداد الكومبو السريع وتنبيهات الهدايا المستلمة
  final StreamController<Map<String, dynamic>> _giftStreamController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get giftStream => _giftStreamController.stream;

  // البث الفوري لمزامنة مشغل الموسيقى وتعديل الوقت التنازلي للأغنية
  final StreamController<Map<String, dynamic>> _musicStreamController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get musicStream => _musicStreamController.stream;

  // البث الفوري لأوامر الإشراف الصارمة والطرد وقفل المقاعد
  final StreamController<Map<String, dynamic>> _adminStreamController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get adminStream => _adminStreamController.stream;

  // ==========================================
  // بدء الاستماع والربط مع أحداث السيرفر
  // ==========================================
  void startListening() {
    if (_socket == null) return;

    _socket.on(SocketEvents.speakingStatus, (dynamic data) => _emitToStream(_speakingStreamController, data));
    _socket.on(SocketEvents.userJoined, (dynamic data) => _emitToStream(_roomStreamController, data));
    _socket.on(SocketEvents.userLeft, (dynamic data) => _emitToStream(_roomStreamController, data));
    _socket.on(SocketEvents.seatUpdate, (dynamic data) => _emitToStream(_roomStreamController, data));

    // 2. الاستماع لأحداث المحادثة والشات ومؤشر الكتابة
    _socket.on(SocketEvents.receiveMessage, (dynamic data) => _emitToStream(_chatStreamController, data));
    _socket.on(SocketEvents.typingStatus, (dynamic data) => _emitToStream(_chatStreamController, data));

    // 3. الاستماع لأحداث طابور عداد الهدايا والأنميشن
    _socket.on(SocketEvents.giftReceived, (dynamic data) => _emitToStream(_giftStreamController, data));
    _socket.on(SocketEvents.giftComboUpdate, (dynamic data) => _emitToStream(_giftStreamController, data));

    // 4. الاستماع لأحداث مزامنة كروت تشغيل الموسيقى
    _socket.on(SocketEvents.musicPlay, (dynamic data) => _emitToStream(_musicStreamController, data));
    _socket.on(SocketEvents.musicPause, (dynamic data) => _emitToStream(_musicStreamController, data));
    _socket.on(SocketEvents.musicSeek, (dynamic data) => _emitToStream(_musicStreamController, data));
    _socket.on(SocketEvents.musicSync, (dynamic data) => _emitToStream(_musicStreamController, data));

    // 5. الاستماع لأحداث الإدارة السريعة
    _socket.on(SocketEvents.kickUser, (dynamic data) => _emitToStream(_adminStreamController, data));
    _socket.on(SocketEvents.muteSeat, (dynamic data) => _emitToStream(_adminStreamController, data));
    _socket.on(SocketEvents.lockSeat, (dynamic data) => _emitToStream(_adminStreamController, data));
  }

  // ميثود داخلي مخصص ومحمي لضخ البيانات بداخل الـ Stream المناسب آلياً ومنع الانهيار
  void _emitToStream(StreamController<Map<String, dynamic>> controller, dynamic data) {
    if (data is Map<String, dynamic> && !controller.isClosed) {
      controller.add(data);
    }
  }

  // ==========================================
  // تدمير وتنظيف الستريمات (Cleanup)
  // ==========================================
  void dispose() {
    _speakingStreamController.close();
    _roomStreamController.close();
    _chatStreamController.close();
    _giftStreamController.close();
    _musicStreamController.close();
    _adminStreamController.close();
  }
}
