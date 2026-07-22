import 'package:joojo_chat/features/room/models/room_event_model.dart';

class RoomEventService {
  // حساب المتبقي من وقت الفعالية أو بدء العد التنازلي لإظهاره كشريط متحرك في الـ UI
  String getEventCountdownText(RoomEventModel event) {
    final now = DateTime.now();

    if (event.startTime != null && now.isBefore(event.startTime!)) {
      final diff = event.startTime!.difference(now);
      return _formatDuration(diff, prefix: 'تبدأ بعد');
    }

    if (event.endTime != null && now.isBefore(event.endTime!)) {
      final diff = event.endTime!.difference(now);
      return _formatDuration(diff, prefix: 'تنتهي بعد');
    }

    return 'الفعالية منتهية';
  }

  // ميثود داخلي خاص لتنسيق الفروق الزمنية بشكل مقروء للمستخدم العربي
  String _formatDuration(Duration duration, {required String prefix}) {
    if (duration.inDays > 0) {
      return '$prefix: ${duration.inDays} يوم و ${duration.inHours % 24} ساعة';
    } else if (duration.inHours > 0) {
      return '$prefix: ${duration.inHours} ساعة و ${duration.inMinutes % 60} دقيقة';
    } else if (duration.inMinutes > 0) {
      return '$prefix: ${duration.inMinutes} دقيقة';
    } else {
      return 'تبدأ الآن';
    }
  }

  // فحص وقائي مستقل لتأكيد ما إذا كانت الفعالية جارية بالفعل بالوقت الحالي للتطبيق
  bool isEventLiveNow(RoomEventModel event) {
    if (event.status != 'active') return false;
    
    final now = DateTime.now();
    final hasStarted = event.startTime == null || now.isAfter(event.startTime!);
    final hasNotEnded = event.endTime == null || now.isBefore(event.endTime!);
    
    return hasStarted && hasNotEnded;
  }
}
