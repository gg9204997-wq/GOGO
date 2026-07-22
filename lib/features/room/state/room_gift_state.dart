import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/gift_model.dart';

class RoomGiftState extends Equatable {
  const RoomGiftState({
    required this.availableGifts,
    required this.activeRoomGifts,
    this.lastReceivedGift,
    required this.isLoading,
    this.errorMessage,
  });

  final List<GiftModel> availableGifts; // الهدايا المتاحة للشراء في المتجر أو البانل
  final List<GiftModel> activeRoomGifts;    // الهدايا النشطة المرسلة داخل الغرفة
  final GiftModel? lastReceivedGift;       // آخر هدية تم استقبالها لتشغيل أنميشن الـ SVGA
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح بانل الهدايا أو دخول الغرفة لأول مرة
  factory RoomGiftState.initial() {
    return const RoomGiftState(
      availableGifts: [],
      activeRoomGifts: [],
      lastReceivedGift: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الهدايا والـ Combo بشكل آمن دون تدمير بقية البيانات
  RoomGiftState copyWith({
    List<GiftModel>? availableGifts,
    List<GiftModel>? activeRoomGifts,
    GiftModel? lastReceivedGift,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomGiftState(
      availableGifts: availableGifts ?? this.availableGifts,
      activeRoomGifts: activeRoomGifts ?? this.activeRoomGifts,
      lastReceivedGift: lastReceivedGift ?? this.lastReceivedGift,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        availableGifts,
        activeRoomGifts,
        lastReceivedGift,
        isLoading,
        errorMessage,
      ];
}
