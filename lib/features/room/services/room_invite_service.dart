import 'package:joojo_chat/features/room/models/room_invite_model.dart';

class RoomInviteService {
  // فحص ما إذا كانت الدعوة لا تزال معلقة وقابلة لاتخاذ إجراء (موافقة/رفض) بالـ UI
  bool isInviteActionable(RoomInviteModel invite) {
    return invite.status == 'pending';
  }

  // صياغة وعرض نص التنبيه الفوري داخل نافذة الدعوة المنبثقة بشكل منسق وجذاب للمستخدم
  String formatInviteDialogMessage({
    required String senderNickname,
    String? customMessage,
  }) {
    if (customMessage != null && customMessage.isNotEmpty) {
      return '$senderNickname: "$customMessage"';
    }
    return 'يدعوك $senderNickname للانضمام إلى الغرفة الصوتية وتبادل الدردشة الآن!';
  }

  // دالة مساعدة لمعالجة كبس أزرار نافذة الدعوة المنبثقة في الـ UI
  // واستدعاء الأكشن المطلوب دون حدوث أي تحذيرات من الـ Dart Analyzer
  void handleInviteAction({
    required RoomInviteModel invite,
    required String actionStatus, // 'accepted' أو 'rejected'
    required void Function(String inviteId, String status) onActionTriggered,
  }) {
    if (isInviteActionable(invite)) {
      onActionTriggered(invite.id, actionStatus);
    }
  }
}
