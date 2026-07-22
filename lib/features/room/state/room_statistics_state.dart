import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_statistics_model.dart';

class RoomStatisticsState extends Equatable {
  const RoomStatisticsState({
    this.roomStats,
    required this.isLoading,
    this.errorMessage,
  });

  final RoomStatisticsModel? roomStats; // كائن بيانات الإحصائيات الشامل التراكمي واليومي للغرفة
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح لوحة تحكم الإحصائيات للمالك أو بدء الاستماع للعدادات
  factory RoomStatisticsState.initial() {
    return const RoomStatisticsState(
      roomStats: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الإحصائيات بشكل آمن ودون تدمير البيانات المستقرة
  RoomStatisticsState copyWith({
    RoomStatisticsModel? roomStats,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomStatisticsState(
      roomStats: roomStats ?? this.roomStats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [roomStats, isLoading, errorMessage];
}
