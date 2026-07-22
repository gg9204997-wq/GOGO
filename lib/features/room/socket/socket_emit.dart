import 'package:joojo_chat/features/room/socket/socket_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketEmit {
  // تم استخدام الـ formal initializer لحل تحذير prefer_initializing_formals بالمليمتر
  SocketEmit({required io.Socket? socket}) : _socket = socket;

  final io.Socket? _socket;

  // تم حذف علامة التعجب الزائدة (!) لمنع تحذير unnecessary_non_null_assertion كلياً
  bool _isReady() => _socket != null && _socket.connected;

  // ==========================================
  // 1. أحداث الغرفة والمقاعد (Room & Seats)
  // ==========================================

  // إرسال إشارة انضمام العضو لغرفة دردشة صوتية محددة
  void emitJoinRoom({required String roomId, required String userId, required String nickname}) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.joinRoom, {
      'room_id': roomId,
      'user_id': userId,
      'nickname': nickname,
    });
  }

  // إرسال إشارة الخروج من الغرفة الصوتية
  void emitLeaveRoom({required String roomId, required String userId}) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.leaveRoom, {
      'room_id': roomId,
      'user_id': userId,
    });
  }

  // بث وميض وحركة الكلام الحية للمتحدث على المقعد
  void emitSpeakingStatus({
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
  // 2. أحداث المحادثة الفورية (Chat & Typing)
  // ==========================================

  // بث الرسالة الفورية المكتوبة لبقية الأعضاء في نفس الثانية
  void emitSendMessage({required String roomId, required String userId, required String message}) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.sendMessage, {
      'room_id': roomId,
      'user_id': userId,
      'message': message,
    });
  }

  // بث وميض مؤشر الكتابة الحالي "يكتب الآن..." أو إيقافه
  void emitTypingStatus({required String roomId, required String userId, required bool isTyping}) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.typingStatus, {
      'room_id': roomId,
      'user_id': userId,
      'is_typing': isTyping,
    });
  }

  // ==========================================
  // 3. أحداث الهدايا والكومبو السريع (Gifts Combo)
  // ==========================================

  // بث عداد ضغطات الهدايا المتتالية (الـ Combo) لتحديث التعداد والحجم لحظياً بالـ UI
  void emitGiftComboClick({
    required String roomId,
    required String giftId,
    required String senderId,
    required String receiverId,
    required int comboCount,
  }) {
    if (!_isReady()) return;
    _socket!.emit(SocketEvents.sendGift, {
      'room_id': roomId,
      'gift_id': giftId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'combo_count': comboCount,
    });
  }

  // ==========================================
  // 4. أحداث مزامنة الموسيقى (Music Sync)
  // ==========================================

  // بث إشارة تشغيل الأغنية أو إيقافها المؤقت أو تحريك موضع شريط الوقت لجميع الحضور
  void emitMusicControl({
    required String roomId,
    required String trackId,
    required String action, // 'play', 'pause', 'seek'
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
  // 5. أحداث التحكم الإداري (Admin Controls)
  // ==========================================

  // بث أوامر الطرد السريع، كتم المايك للمقعد، أو قفله من قِبل المشرفين لتحديث الغرفة فوراً
  void emitAdminAction({
    required String roomId,
    required String actionType, // 'kick', 'mute_seat', 'lock_seat'
    required Map<String, dynamic> actionData,
  }) {
    if (!_isReady()) return;

    String eventName = SocketEvents.kickUser;
    if (actionType == 'mute_seat') eventName = SocketEvents.muteSeat;
    if (actionType == 'lock_seat') eventName = SocketEvents.lockSeat;

    _socket!.emit(eventName, {
      'room_id': roomId,
      ...actionData,
    });
  }
}
