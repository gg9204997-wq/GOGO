import 'dart:collection';
import 'package:joojo_chat/features/room/models/gift_model.dart';

class RoomGiftService {
  // طابور (Queue) لتخزين الهدايا الواردة تباعاً لمنع تداخل وتصادم الأنميشن الفاخر في واجهة الغرفة
  final Queue<GiftModel> _giftAnimationQueue = Queue<GiftModel>();
  bool _isAnimationPlaying = false;

  // إضافة هدية جديدة إلى طابور العرض فور ورودها من الـ Provider أو السوكيت
  void queueIncomingGift({
    required GiftModel gift,
    required void Function(GiftModel) onPlayAnimation,
  }) {
    // نقوم بجدولة الهدايا التي تمتلك أنميشن أو ملفات حركة فاخرة فقط
    if (gift.hasAnimation) {
      _giftAnimationQueue.addLast(gift);
      _checkAndPlayNextAnimation(onPlayAnimation);
    }
  }

  // فحص الطابور وتشغيل الأنميشن التالي آلياً عند انتهاء الأنميشن الحالي
  void _checkAndPlayNextAnimation(void Function(GiftModel) onPlayAnimation) {
    if (_isAnimationPlaying || _giftAnimationQueue.isEmpty) return;

    _isAnimationPlaying = true;
    final nextGift = _giftAnimationQueue.removeFirst();
    
    // استدعاء الكولباك لتشغيل مشغل الأنميشن (Lottie / SVGA Player) في الـ UI
    onPlayAnimation(nextGift);
  }

  // تُستدعى هذه الدالة من طرف واجهة الرسوم المتحركة فور انتهاء الحركة البرمجية للهدية
  void onAnimationCompleted(void Function(GiftModel) onPlayAnimation) {
    _isAnimationPlaying = false;
    _checkAndPlayNextAnimation(onPlayAnimation);
  }

  // تفريغ وتنظيف طابور الهدايا بالكامل عند مغادرة الغرفة الصوتية
  void clearGiftQueue() {
    _giftAnimationQueue.clear();
    _isAnimationPlaying = false;
  }

  // تحديد الفئة السعرية للهدية برمجياً لتحديد حجم وتأثير الـ Combo وتكبير خط الأرقام بالـ UI
  String getGiftTier(GiftModel gift) {
    if (gift.price >= 1000) {
      return 'mythic'; // هدايا ملكية فاخرة جداً تملأ الشاشة
    } else if (gift.price >= 500) {
      return 'legendary'; // هدايا أسطورية بتأثيرات حركية كبيرة
    } else if (gift.price >= 100) {
      return 'epic'; // هدايا متوسطة
    }
    return 'normal'; // هدايا بسيطة وتأثيرات عادية
  }
}
