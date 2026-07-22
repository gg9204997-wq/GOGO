import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/mic_request_model.dart';

class RoomMicState extends Equatable {
  const RoomMicState({
    required this.pendingRequests,
    required this.isLoading,
    this.errorMessage,
  });

  final List<MicRequestModel> pendingRequests; // قائمة طلبات المايك المعلقة والمنتظرة في الغرفة
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند التعامل مع نظام خطوط المايكات لأول مرة بداخل الغرفة
  factory RoomMicState.initial() {
    return const RoomMicState(
      pendingRequests: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة طلبات المايك بشكل آمن ومطابق تام لقواعد التحديث الفردي
  RoomMicState copyWith({
    List<MicRequestModel>? pendingRequests,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomMicState(
      pendingRequests: pendingRequests ?? this.pendingRequests,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [pendingRequests, isLoading, errorMessage];
}
