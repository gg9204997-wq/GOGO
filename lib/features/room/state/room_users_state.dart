import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_user_model.dart';

class RoomUsersState extends Equatable {
  const RoomUsersState({
    required this.activeUsers,
    this.selectedRoomUser,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomUserModel> activeUsers;    // قائمة الحضور والمستخدمين النشطين داخل الغرفة حالياً
  final RoomUserModel? selectedRoomUser;    // تفاصيل مستخدم محدد تم اختياره لعرض بطاقة بروفايله بالـ UI
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح قائمة الحضور أو دخول الغرفة لأول مرة
  factory RoomUsersState.initial() {
    return const RoomUsersState(
      activeUsers: [],
      selectedRoomUser: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الحضور والمشرفين بشكل آمن ودون تدمير قائمة البيانات المستقرة
  RoomUsersState copyWith({
    List<RoomUserModel>? activeUsers,
    RoomUserModel? selectedRoomUser,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomUsersState(
      activeUsers: activeUsers ?? this.activeUsers,
      selectedRoomUser: selectedRoomUser ?? this.selectedRoomUser,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        activeUsers,
        selectedRoomUser,
        isLoading,
        errorMessage,
      ];
}
