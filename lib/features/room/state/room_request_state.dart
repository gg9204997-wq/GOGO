import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_request_model.dart';

class RoomRequestState extends Equatable {
  const RoomRequestState({
    required this.roomRequests,
    required this.pendingQueueRequests,
    this.selectedRequest,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomRequestModel> roomRequests;         // كافة طلبات الغرفة بناءً على الفلترة اليدوية
  final List<RoomRequestModel> pendingQueueRequests; // الطلبات المعلقة في الطابور الحي المحدث لحظياً للـ Admin
  final RoomRequestModel? selectedRequest;           // تفاصيل طلب محدد تم اختياره للمراجعة
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح لوحة طلبات الانتظار والمايكات لأول مرة
  factory RoomRequestState.initial() {
    return const RoomRequestState(
      roomRequests: [],
      pendingQueueRequests: [],
      selectedRequest: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الطلبات بشكل آمن ودون تدمير مصفوفة طابور الانتظار
  RoomRequestState copyWith({
    List<RoomRequestModel>? roomRequests,
    List<RoomRequestModel>? pendingQueueRequests,
    RoomRequestModel? selectedRequest,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomRequestState(
      roomRequests: roomRequests ?? this.roomRequests,
      pendingQueueRequests: pendingQueueRequests ?? this.pendingQueueRequests,
      selectedRequest: selectedRequest ?? this.selectedRequest,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        roomRequests,
        pendingQueueRequests,
        selectedRequest,
        isLoading,
        errorMessage,
      ];
}
