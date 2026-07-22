import 'package:joojo_chat/features/room/models/room_statistics_model.dart';

class RoomStatisticsService {
  // ==========================================
  // تنسيق الأرقام والعملات الرقمية للـ UI
  // ==========================================

  // تنسيق وعرض العملات أو الهدايا التراكمية بشكل مختصر وجذاب داخل لوحة الغرفة (مثل: 12.4K أو 1.2M)
  String formatCompactCounter(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  // حساب النسبة المئوية لإيرادات اليوم التراكمية مقارنة بهدف الغرفة اليومي أو الإجمالي (Revenue Target)
  double calculateRevenueProgress({
    required int todayGifts,
    required int dailyTargetGifts,
  }) {
    if (dailyTargetGifts <= 0) return 0.0;
    
    final double progress = todayGifts / dailyTargetGifts;
    return progress.clamp(0.0, 1.0); // حماية النسبة لعدادات فلاتر الرسومية
  }

  // ==========================================
  // حسابات وتحليلات زمنية للغرفة
  // ==========================================

  // تحويل إجمالي دقائق التحدث (Total Voice Minutes) إلى صيغة ساعات ودقائق مقروءة للزوار والمالك
  String formatTotalVoiceHours(int totalMinutes) {
    if (totalMinutes <= 0) return '0 دقيقة';
    
    final int hours = totalMinutes ~/ 60;
    final int remainingMinutes = totalMinutes % 60;

    if (hours > 0) {
      return '$hours ساعة و $remainingMinutes دقيقة';
    }
    return '$remainingMinutes دقيقة';
  }

  // حساب متوسط مدة الجلسة الصوتية الواحدة (Average Session Duration) داخل الغرفة الصوتية
  String calculateAverageSessionDuration(RoomStatisticsModel? stats) {
    if (stats == null) return '0 دقيقة';
    
    // تجنب القسمة على صفر برمجياً
    final int totalSessions = stats.totalSessions; // الوصول للحقل بناءً على دوال الـ Repositories
    final int totalMinutes = stats.totalVoiceMinutes;
    
    if (totalSessions <= 0 || totalMinutes <= 0) return '0 دقيقة';
    
    final int average = totalMinutes ~/ totalSessions;
    return '$average دقيقة / جلسة';
  }
}
