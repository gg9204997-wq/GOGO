class SocketEvents {
  // منع إنشاء نسخة من الكلاس لأنه يحتوي على ثوابت فقط
  SocketEvents._();

  // ==========================================
  // أحداث الغرفة والمقاعد (Room & Seats)
  // ==========================================
  static const String joinRoom = 'join_room';
  static const String leaveRoom = 'leave_room';
  static const String userJoined = 'user_joined';
  static const String userLeft = 'user_left';
  static const String speakingStatus = 'speaking_status';
  static const String seatUpdate = 'seat_update';

  // ==========================================
  // أحداث المحادثة والشات الفوري (Chat & Typing)
  // ==========================================
  static const String sendMessage = 'send_message';
  static const String receiveMessage = 'receive_message';
  static const String typingStatus = 'typing_status';

  // ==========================================
  // أحداث الهدايا والكومبو (Gifts & Combo)
  // ==========================================
  static const String sendGift = 'send_gift';
  static const String giftReceived = 'gift_received';
  static const String giftComboUpdate = 'gift_combo_update';

  // ==========================================
  // أحداث تشغيل الموسيقى ومزامنتها (Music Sync)
  // ==========================================
  static const String musicPlay = 'music_play';
  static const String musicPause = 'music_pause';
  static const String musicSeek = 'music_seek';
  static const String musicSync = 'music_sync';

  // ==========================================
  // أحداث الإدارة والإشراف (Admin Actions)
  // ==========================================
  static const String kickUser = 'kick_user';
  static const String banUser = 'ban_user';
  static const String muteSeat = 'mute_seat';
  static const String lockSeat = 'lock_seat';
}
