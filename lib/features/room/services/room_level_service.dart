import 'package:joojo_chat/features/room/models/room_level_history_model.dart';

class RoomLevelService {
  // دالة لحساب نسبة التقدم المئوية داخل المستوى الحالي لرسم الـ Progress Bar بالـ UI
  double calculateLevelProgress({
    required int currentXp,
    required int nextLevelRequiredXp,
  }) {
    if (nextLevelRequiredXp <= 0) return 0.0;
    
    // حساب النسبة وعمل تصفية رياضية لحمايتها بين 0.0 و 1.0 (إجباري لـ LinearProgressIndicator)
    final double progress = currentXp / nextLevelRequiredXp;
    return progress.clamp(0.0, 1.0);
  }

  // حساب كمية النقاط المتبقية (Remaining XP) للوصول إلى المستوى الصوتي التالي
  int getRemainingXpToNextLevel({
    required int currentXp,
    required int nextLevelRequiredXp,
  }) {
    final int remaining = nextLevelRequiredXp - currentXp;
    return remaining < 0 ? 0 : remaining;
  }

  // صياغة اسم أو مسمى المستوى للغرفة بناءً على رقمها لتعزيز الجاذبية بالـ UI
  String getLevelBadgeName(int level) {
    if (level >= 50) return 'التاج الملكي الفاخر';
    if (level >= 30) return 'القصر الأسطوري المتميز';
    if (level >= 15) return 'الغرفة الماسية المتقدمة';
    if (level >= 5)  return 'غرفة ذهبية نشطة';
    return 'غرفة برونزية مبتدئة';
  }

  // فحص وقائي سريع لمعرفة ما إذا كانت نقاط الـ XP المضافة مؤهلة لترقية الغرفة منطقياً
  bool checkIsLevelUpTriggered({
    required int currentTotalXp,
    required int xpAdded,
    required int nextLevelThreshold,
  }) {
    return (currentTotalXp + xpAdded) >= nextLevelThreshold;
  }
}
