import 'package:joojo_chat/features/room/models/room_ban_model.dart';

class RoomNotificationService {
  // ==========================================
  // BAN & KICK LOGIC MANAGEMENT
  // ==========================================

  // حساب الوقت المتبقي لانتهاء الحظر المؤقت وعرضه للمستخدم المحظور عند محاولة الدخول
  String getRemainingBanTime(RoomBanModel ban) {
    if (ban.permanent || ban.expiresAt == null) {
      return 'هذا الحظر دائم ومطلق من قِبل إدارة المنصة والاتحاد';
    }

    final now = DateTime.now();
    if (now.isAfter(ban.expiresAt!)) {
      return 'انتهت فترة الحظر التلقائية';
    }

    final difference = ban.expiresAt!.difference(now);

    if (difference.inDays > 0) {
      return 'متبقي على فك الحظر: ${difference.inDays} يوم و ${difference.inHours % 24} ساعة';
    } else if (difference.inHours > 0) {
      return 'متبقي على فك الحظر: ${difference.inHours} ساعة و ${difference.inMinutes % 60} دقيقة';
    } else {
      return 'متبقي على فك الحظر: ${difference.inMinutes} دقيقة';
    }
  }

  // صياغة نص رسالة النظام التلقائية لبثها في شات الغرفة عند قيام المشرف بحظر مستخدم
  String formatBanSystemMessage({
    required String username,
    required bool isPermanent,
    String? reason,
  }) {
    final actionType = isPermanent ? 'حظره نهائياً' : 'طرده مؤقتاً';
    final reasonText = (reason != null && reason.isNotEmpty) ? 'بسبب: $reason' : 'لمخالفة قوانين الغرفة';
    return 'قام المشرف بـ $actionType للعضو ($username) $reasonText.';
  }

  // دالة وقائية حذرة للتحقق من انتهاء الصلاحية الزمنية للحظر المؤقت محلياً
  bool isBanExpired(RoomBanModel ban) {
    if (ban.permanent || ban.expiresAt == null) return false;
    return DateTime.now().isAfter(ban.expiresAt!);
  }
}
