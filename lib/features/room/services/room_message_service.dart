import 'package:joojo_chat/features/room/models/room_message_model.dart';

class RoomMessageService {
  // تصفية الرسائل المارة محلياً للتأكد من عدم احتوائها على نصوص مسيئة قبل تمريرها للـ Repository لتقليل ضغط السيرفر
  bool isMessageContentSafe(String text) {
    if (text.trim().isEmpty) return false;
    
    // قائمة الكلمات المحظورة الافتراضية للغرفة
    const bannedWords = ['مسيء1', 'مسيء2', 'مسيء3']; 
    final lowerText = text.toLowerCase();
    
    return !bannedWords.any((word) => lowerText.contains(bannedWords as Pattern));
  }

  // ميثود لمساعدة الـ UI لتحديد ما إذا كانت الرسالة مرسلة من المستخدم الحالي (Me) أم من شخص آخر
  // لرسم صندوق النص في الجهة اليمنى أو اليسرى بالشاشة
  bool isMyMessage({required RoomMessageModel message, required String currentUserId}) {
    return message.sender == currentUserId;
  }

  // صياغة رسائل النظام التلقائية بشكل منسق (مثل رسائل الترحيب التلقائية عند دخول مستخدم VIP)
  String formatSystemWelcomeMessage({required String nickname, String? vipBadge}) {
    final badge = (vipBadge != null && vipBadge.isNotEmpty) ? ' [$vipBadge] ' : ' ';
    return 'دخل النجم المميز$badge($nickname) إلى الغرفة الآن 🎉، رحبوا به!';
  }

  // التحقق من صلاحية تعديل الرسالة برمجياً (مثل منع تعديل الرسائل التي مر عليها أكثر من 5 دقائق)
  bool canEditMessage(RoomMessageModel message) {
    if (message.isSystem) return false; // رسائل النظام لا تعدل
    
    final now = DateTime.now();
    final difference = now.difference(message.createdAt);
    
    return difference.inMinutes <= 5; // صلاحية التعديل خلال 5 دقائق فقط
  }
}
