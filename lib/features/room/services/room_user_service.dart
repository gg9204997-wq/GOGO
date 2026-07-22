import 'package:joojo_chat/features/room/models/room_user_model.dart';

class RoomUserService {
  // ==========================================
  // تصفية وفرز قائمة الحضور (User Filtering)
  // ==========================================

  // استخراج قائمة طاقم الإدارة المتواجدين حالياً داخل الغرفة (الملاك والمشرفين)
  List<RoomUserModel> filterRoomManagement(List<RoomUserModel> activeUsers) {
    return activeUsers.where((user) => user.isOwner || user.isModerator).toList();
  }

  // استخراج قائمة الجمهور المستمعين فقط (Audience) الذين لا يمتلكون أي صلاحيات إدارية
  List<RoomUserModel> filterNormalAudience(List<RoomUserModel> activeUsers) {
    return activeUsers.where((user) => !user.isOwner && !user.isModerator).toList();
  }

  // استخراج قائمة المستخدمين الجالسين حالياً على مقاعد التحدث الصوتي (الجالسين على مايك)
  // بناءً على منطق الـ Repository الخاص بك (حيث مقعد -1 يعني ليس على المقعد)
  List<RoomUserModel> filterActiveSpeakers(List<RoomUserModel> activeUsers) {
    return activeUsers.where((user) => user.seatNumber >= 0).toList();
  }

  // ==========================================
  // تحققات وقائية وفحص الصلاحيات بالـ UI
  // ==========================================

  // فحص حركي سريع لمعرفة ما إذا كان مستخدم معين يمتلك صلاحية طرد أو إدارة الغرفة
  bool canUserManageRoom(RoomUserModel? user) {
    if (user == null || user.isBanned) return false;
    return user.isOwner || user.isModerator;
  }

  // إرجاع لون أو مسمى الرتبة الخاص بالعضو لعرضه بشكل جمالي بجانب الاسم في الشات وقائمة الحضور
  String getUserRoleLabel(RoomUserModel user) {
    if (user.isOwner) return 'المالك';
    if (user.isModerator) return 'مشرف الغرفة';
    
    // تحويل الـ role النصي الممرر من السيرفر لمسمى مفهوم
    switch (user.role) {
      case 'vip':
        return 'عضو VIP';
      case 'premium':
        return 'عضو مميز';
      default:
        return 'مستمع';
    }
  }
}
