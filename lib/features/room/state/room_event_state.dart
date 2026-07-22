import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_event_model.dart';

class RoomEventState extends Equatable {
  const RoomEventState({
    required this.roomEvents,
    required this.isLoading,
    this.selectedEvent,
    this.errorMessage,
  });

  final List<RoomEventModel> roomEvents;
  final RoomEventModel? selectedEvent;
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح لوحة جدولة وعرض الفعاليات لأول مرة داخل الغرفة الصوتية
  factory RoomEventState.initial() {
    return const RoomEventState(
      roomEvents: [],
      isLoading: false,
      selectedEvent: null,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الفعاليات بشكل آمن دون تدمير مصفوفة البيانات الأساسية
  RoomEventState copyWith({
    List<RoomEventModel>? roomEvents,
    RoomEventModel? selectedEvent,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomEventState(
      roomEvents: roomEvents ?? this.roomEvents,
      selectedEvent: selectedEvent ?? this.selectedEvent,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند زوال الخطأ بنجاح
    );
  }

  @override
  List<Object?> get props => [roomEvents, selectedEvent, isLoading, errorMessage];
}
