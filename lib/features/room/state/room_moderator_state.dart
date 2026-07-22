import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_moderator_model.dart';

class RoomModeratorState extends Equatable {
  const RoomModeratorState({
    required this.moderators,
    required this.activeModerators,
    required this.expiredModerators,
    this.selectedModerator,
    required this.moderatorsCount,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomModeratorModel> moderators;        // قائمة جميع المشرفين
  final List<RoomModeratorModel> activeModerators;  // المشرفون النشطون حالياً
  final List<RoomModeratorModel> expiredModerators; // المشرفون الذين انتهت فترة رتبتهم
  final RoomModeratorModel? selectedModerator;       // تفاصيل مشرف محدد تم اختياره
  final int moderatorsCount;                        // العدد الإجمالي للمشرفين
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح قائمة المشرفين لأول مرة
  factory RoomModeratorState.initial() {
    return const RoomModeratorState(
      moderators: [],
      activeModerators: [],
      expiredModerators: [],
      selectedModerator: null,
      moderatorsCount: 0,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الإشراف بشكل آمن ومطابق تام لقواعد التحديث الفردي
  RoomModeratorState copyWith({
    List<RoomModeratorModel>? moderators,
    List<RoomModeratorModel>? activeModerators,
    List<RoomModeratorModel>? expiredModerators,
    RoomModeratorModel? selectedModerator,
    int? moderatorsCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomModeratorState(
      moderators: moderators ?? this.moderators,
      activeModerators: activeModerators ?? this.activeModerators,
      expiredModerators: expiredModerators ?? this.expiredModerators,
      selectedModerator: selectedModerator ?? this.selectedModerator,
      moderatorsCount: moderatorsCount ?? this.moderatorsCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        moderators,
        activeModerators,
        expiredModerators,
        selectedModerator,
        moderatorsCount,
        isLoading,
        errorMessage,
      ];
}
