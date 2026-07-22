import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_level_history_model.dart';

class RoomLevelHistoryState extends Equatable {
  const RoomLevelHistoryState({
    required this.levelHistory,
    this.latestLevel,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomLevelHistoryModel> levelHistory; // سجل ترقيات ومستويات الغرفة بالكامل
  final RoomLevelHistoryModel? latestLevel;       // آخر مستوى وصلت إليه الغرفة حالياً
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند التعامل مع نظام مستويات الغرفة لأول مرة
  factory RoomLevelHistoryState.initial() {
    return const RoomLevelHistoryState(
      levelHistory: [],
      latestLevel: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة مستويات الغرفة بشكل آمن ومطابق تام لقواعد التحديث الفردي
  RoomLevelHistoryState copyWith({
    List<RoomLevelHistoryModel>? levelHistory,
    RoomLevelHistoryModel? latestLevel,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomLevelHistoryState(
      levelHistory: levelHistory ?? this.levelHistory,
      latestLevel: latestLevel ?? this.latestLevel,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        levelHistory,
        latestLevel,
        isLoading,
        errorMessage,
      ];
}
