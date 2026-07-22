import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_ban_model.dart';

class RoomAdminState extends Equatable {
  const RoomAdminState({
    required this.roomBans,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomBanModel> roomBans;
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح لوحة تحكم المحظورين لأول مرة داخل الغرفة
  factory RoomAdminState.initial() {
    return const RoomAdminState(
      roomBans: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الحظر بشكل آمن دون تدمير مصفوفة المحظورين
  RoomAdminState copyWith({
    List<RoomBanModel>? roomBans,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomAdminState(
      roomBans: roomBans ?? this.roomBans,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null بعد زوال الخطأ
    );
  }

  @override
  List<Object?> get props => [roomBans, isLoading, errorMessage];
}
