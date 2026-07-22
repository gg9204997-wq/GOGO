import 'package:joojo_chat/features/room/models/seat_model.dart';

class RoomSeatService {
  // ==========================================
  // فحص وإدارة حالة المقاعد بالـ UI
  // ==========================================

  // البحث عن رقم مقعد مستخدم معين داخل الغرفة (معرفة أين يجلس المستخدم الحالي)
  int getUserSeatNumber({required List<SeatModel> seatList, required String userId}) {
    if (userId.isEmpty) return -1;
    final index = seatList.indexWhere((seat) => seat.userId == userId);
    return index != -1 ? seatList[index].seatNumber : -1;
  }

  // التحقق وقائياً مما إذا كان المستخدم يمتلك مقعداً صوتياً بالفعل بداخل الغرفة لمنع الصعود المكرر
  bool isUserOnAnySeat({required List<SeatModel> seatList, required String userId}) {
    if (userId.isEmpty) return false;
    return seatList.any((seat) => seat.userId == userId);
  }

  // فرز واستخراج المقاعد المغلقة والمحجوزة من قِبل المشرفين (Locked Seats)
  List<SeatModel> getLockedSeats(List<SeatModel> seatList) {
    return seatList.where((seat) => seat.isLocked).toList();
  }

  // استخراج المقاعد الشاغرة والفارغة المتاحة حالياً لصعود الأعضاء (Available Seats)
  List<SeatModel> getAvailableEmptySeats(List<SeatModel> seatList) {
    return seatList.where((seat) => seat.isEmpty && !seat.isLocked).toList();
  }

  // ==========================================
  // ميزات مساعدة للأجهزة والواجهات
  // ==========================================

  // فحص وقائي لمعرفة ما إذا كان المقعد يمتلك مستخدماً نشطاً ومسموحاً له بالتحدث محلياً
  bool canSeatSpeak(SeatModel seat) {
    // يعتمد على منطق الـ Getters الجاهزة بداخل الـ Model الفعلي الخاص بك
    return seat.hasUser && !seat.isLocked && !seat.isMuted;
  }

  // تخصيص مسمى أو لون مقعد صوتي مميز بالـ UI بناءً على الـ seatType (مثل مقعد الملك أو المشرف)
  String getSeatTypeLabel(String seatType) {
    switch (seatType) {
      case 'boss':
        return 'مقعد المالك';
      case 'vip':
        return 'مقعد كبار الشخصيات';
      case 'moderator':
        return 'مقعد الإشراف';
      default:
        return 'مقعد عادي';
    }
  }
}
