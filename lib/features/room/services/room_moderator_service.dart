import 'package:joojo_chat/features/room/models/room_moderator_model.dart';

class RoomModeratorService {
  // فحص وقائي سريع لمعرفة ما إذا كان المشرف يمتلك صلاحية إدارية معينة محلياً (مثل صلاحية الطرد أو كتم الصوت)
  bool hasPermission({
    required RoomModeratorModel? moderator,
    required String permissionKey,
  }) {
    if (moderator == null || !moderator.active) return false;

    // فحص ما إذا كانت رتبة المشرف مؤقتة وانتهت صلاحيتها زمنياً
    if (isModeratorExpired(moderator)) return false;

    // فحص خريطة الصلاحيات الديناميكية الممررة من قاعدة البيانات
    final permissions = moderator.permissions;
    return permissions[permissionKey] as bool? ?? false;
  }

  // فحص وقائي لمعرفة ما إذا كانت صلاحية رتبة الإشراف المؤقتة قد انتهت زمنياً بالكامل
  bool isModeratorExpired(RoomModeratorModel moderator) {
    if (moderator.expiresAt == null) return false; // إشراف دائم
    return DateTime.now().isAfter(moderator.expiresAt!);
  }

  // فرز وتصفية قائمة المشرفين لاستخراج المشرفين النشطين الفعليين المتواجدين حالياً باللوحة
  List<RoomModeratorModel> filterActiveModerators(List<RoomModeratorModel> allModerators) {
    return _filterModeratorsByState(allModerators, checkActive: true);
  }

  // فرز وتصفية قائمة المشرفين لاستخراج الحسابات المجمدة أو منتهية الصلاحية
  List<RoomModeratorModel> filterInactiveModerators(List<RoomModeratorModel> allModerators) {
    return _filterModeratorsByState(allModerators, checkActive: false);
  }

  // ميثود داخلي مخصص ومحمي لتوحيد عملية الفرز والفلترة البرمجية دون تكرار الكود
  List<RoomModeratorModel> _filterModeratorsByState(
    List<RoomModeratorModel> allModerators, {
    required bool checkActive,
  }) {
    return allModerators.where((moderator) {
      final bool isExpired = isModeratorExpired(moderator);
      if (checkActive) {
        return moderator.active && !isExpired;
      } else {
        return !moderator.active || isExpired;
      }
    }).toList();
  }
}
