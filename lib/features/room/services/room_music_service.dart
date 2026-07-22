import 'package:joojo_chat/features/room/models/room_music_model.dart';

class RoomMusicService {
  // ميثود لتحويل موضع الأغنية بالثواني (Position / Duration) إلى صيغة زمنية نصية مقروءة للـ UI (مثل: 03:45)
  String formatTrackTime(int seconds) {
    if (seconds <= 0) return '00:00';
    
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;

    // استخدام الـ padLeft لإضافة صفر في البداية إذا كان الرقم أقل من 10 لضمان الاتساق والشكل الجمالي
    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  // حساب النسبة المئوية للامتلاء (Progress Percentage) لتغذية شريط الـ Music Progress Slider بالـ UI
  double calculatePlaybackProgress({
    required int currentPositionInSeconds,
    required int totalDurationInSeconds,
  }) {
    if (totalDurationInSeconds <= 0) return 0.0;
    
    // تصفية النسبة وتحديدها رياضياً لحمايتها بين 0.0 و 1.0 منعاً لانهيار الـ Flutter Silders
    final double progress = currentPositionInSeconds / totalDurationInSeconds;
    return progress.clamp(0.0, 1.0);
  }

  // ميثود وقائي للتحقق من صلاحية روابط الميديا والتحقق مما إذا كانت الأغنية تمتلك رابطاً صالحاً للتشغيل بالهاتف
  bool isTrackPlayable(RoomMusicModel? music) {
    if (music == null) return false;
    
    // فحص حقل الـ file_url أو الـ audio_url؛ وتفادي الروابط الفارغة
    return music.url != null && music.url!.trim().isNotEmpty;
  }
}
