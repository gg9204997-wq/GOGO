import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_rank_model.dart';

class RoomRankState extends Equatable {
  const RoomRankState({
    required this.ranks,
    this.currentUserRank,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomRankModel> ranks;       // مصفوفة قائمة الصدارة المتنافسة داخل الغرفة
  final RoomRankModel? currentUserRank;  // ترتيب وبيانات النقاط الحالية للمستخدم المستعلم
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح لوحات الصدارة أو التنافس لأول مرة داخل الغرفة
  factory RoomRankState.initial() {
    return const RoomRankState(
      ranks: [],
      currentUserRank: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الترتيب والصدارة بشكل آمن دون تدمير بقية المتغيرات
  RoomRankState copyWith({
    List<RoomRankModel>? ranks,
    RoomRankModel? currentUserRank,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomRankState(
      ranks: ranks ?? this.ranks,
      currentUserRank: currentUserRank ?? this.currentUserRank,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند زوال الخطأ بنجاح
    );
  }

  @override
  List<Object?> get props => [
        ranks,
        currentUserRank,
        isLoading,
        errorMessage,
      ];
}
