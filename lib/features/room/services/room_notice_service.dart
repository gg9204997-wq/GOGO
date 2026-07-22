import 'package:joojo_chat/features/room/models/room_notice_model.dart';

class RoomNoticeService {
  // تصفية وقائية سريعة لاستخراج الإعلانات المثبتة (Pinned) فقط لعرضها في شريط التمرير العلوي للغرفة (Marquee Banner)
  List<RoomNoticeModel> getPinnedNotices(List<RoomNoticeModel> allNotices) {
    return allNotices.where((notice) => notice.isPinned && notice.isActive && !notice.isExpired).toList();
  }

  // التحقق برمجياً مما إذا كان الإعلان يتطلب تفعيل شريط تنبيهي منبثق (Alert Badge) بناءً على أهميته أو محتواه
  bool isUrgentNotice(RoomNoticeModel notice) {
    if (!notice.isActive || notice.isExpired) return false;
    
    // فحص حقل العنوان وحقل الرسالة (الذي تم تصحيحه ليتطابق مع حقول الموديل الفعلي لديك)
    final String title = notice.title.toLowerCase();
    final String messageText = notice.message.toLowerCase();
    
    return title.contains('هام') || 
           title.contains('عاجل') || 
           messageText.contains('قوانين') || 
           notice.isPinned;
  }

  // دالة مساعدة لتأكيد صلاحية الإعلان منطقياً ومطابقة الوقت الحالي قبل عرضه بداخل واجهة الغرفة الصوتية
  bool verifyNoticeValidity(RoomNoticeModel notice) {
    return notice.isActive && !notice.isExpired;
  }
}
