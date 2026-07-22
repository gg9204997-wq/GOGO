import 'package:joojo_chat/features/room/models/room_rank_model.dart';

class RoomRankService {
  // ==========================================
  // فرز وتصفية المراتب بالـ UI (Top 3 Ranks)
  // ==========================================

  // استخراج المستخدم الحاصل على المركز الأول (التاج الذهبي)
  RoomRankModel? getTopOne(List<RoomRankModel> ranksList) {
    if (ranksList.isEmpty) return null;
    return ranksList.first;
  }

  // استخراج المستخدم الحاصل على المركز الثاني (التاج الفضي)
  RoomRankModel? getTopTwo(List<RoomRankModel> ranksList) {
    if (ranksList.length < 2) return null;
    return ranksList[1];
  }

  // استخراج المستخدم الحاصل على المركز الثالث (التاج البرونزي)
  RoomRankModel? getTopThree(List<RoomRankModel> ranksList) {
    if (ranksList.length < 3) return null;
    return ranksList[2];
  }

  // تصفية وعزل بقية المتنافسين من المركز الرابع فما فوق لعرضهم بقائمة مخصصة بالـ UI
  List<RoomRankModel> getRemainingCompetitors(List<RoomRankModel> ranksList) {
    if (ranksList.length <= 3) return [];
    return ranksList.sublist(3);
  }

  // ==========================================
  // دوال وقائية وتنسيق أيقونات الصدارة
  // ==========================================

  // إرجاع مسار الصورة أو التاج المناسب للمستخدم بناءً على مركزه الترتيبي بالـ UI
  String getRankCrownAsset(int index) {
    // معامل الـ index يبدأ من 0 في قائمة المترادفات الحركية (Index 0 = Center 1)
    switch (index) {
      case 0:
        return 'assets/images/ranks/gold_crown.png'; // المركز الأول
      case 1:
        return 'assets/images/ranks/silver_crown.png'; // المركز الثاني
      case 2:
        return 'assets/images/ranks/bronze_crown.png'; // المركز الثالث
      default:
        return 'assets/images/ranks/normal_star.png'; // بقية المراكز
    }
  }

  // فحص حركي لمساعدة الـ UI لمعرفة ما إذا كان المستخدم الحالي قد أحرز تقدماً في سكور الصدارة مقارنة بسكور سابق
  bool checkHasProgressed({required int newScore, required int oldScore}) {
    return newScore > oldScore;
  }
}
