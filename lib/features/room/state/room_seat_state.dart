import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/seat_model.dart';

class RoomSeatState extends Equatable {
  const RoomSeatState({
    required this.seats,
    required this.isLoading,
    this.errorMessage,
  });

  final List<SeatModel> seats; // مصفوفة المقاعد الثمانية للغرفة الصوتية
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح شاشة الغرفة الصوتية ورسم المقاعد لأول مرة
  factory RoomSeatState.initial() {
    return const RoomSeatState(
      seats: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة المقاعد والوميض بشكل آمن ودون تدمير البيانات المستقرة
  RoomSeatState copyWith({
    List<SeatModel>? seats,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomSeatState(
      seats: seats ?? this.seats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [seats, isLoading, errorMessage];
}
