import 'package:joojo_chat/features/room/models/room_background_model.dart';

class RoomBackgroundService {
  // تفريغ وتحديد نوع ثيم الخلفية الحالي المختار من الـ Provider
  // لكي يعرف الـ Widgets ما إذا كانت ستقوم برسم صورة ثابتة أم تشغيل ملف فيديو حركي بالخلفية
  String determineBackgroundType(RoomBackgroundModel background) {
    if (background.hasVideo) {
      return 'video';
    } else if (background.type == 'animation' || background.isAnimation) {
      return 'animation';
    }
    return 'image';
  }

  // ميثود وقائي للتحقق من صلاحية روابط الخلفيات قبل تمريرها لمشغلات الميديا بالـ UI
  bool isValidBackgroundSource(RoomBackgroundModel background) {
    if (background.type == 'video' || background.hasVideo) {
      return background.videoUrl.isNotEmpty;
    }
    return background.imageUrl.isNotEmpty;
  }

  // فرز وتصفية الخلفيات المفضلة محلياً أو إرجاع ثيم افتراضي فارغ (Fallback) 
  // في حال تعثر الاتصال بقاعدة البيانات لضمان عدم بقاء واجهة المستخدم سوداء
  RoomBackgroundModel getFallbackTheme() {
    return RoomBackgroundModel.empty();
  }
}
