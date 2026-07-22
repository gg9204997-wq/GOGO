import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_notice_model.dart';

class RoomNoticeState extends Equatable {
  const RoomNoticeState({
    required this.notices,
    this.selectedNotice,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomNoticeModel> notices;    // قائمة الإعلانات المضافة أو النشطة داخل الغرفة
  final RoomNoticeModel? selectedNotice;  // تفاصيل إعلان معين تم تحديده للعرض أو التحديث
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند التعامل مع نظام الإعلانات واللوحات لأول مرة
  factory RoomNoticeState.initial() {
    return const RoomNoticeState(
      notices: [],
      selectedNotice: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الإعلانات بشكل آمن ومطابق تام لقواعد التحديث الفردي
  RoomNoticeState copyWith({
    List<RoomNoticeModel>? notices,
    RoomNoticeModel? selectedNotice,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomNoticeState(
      notices: notices ?? this.notices,
      selectedNotice: selectedNotice ?? this.selectedNotice,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        notices,
        selectedNotice,
        isLoading,
        errorMessage,
      ];
}
