import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_member_model.dart';

class RoomMemberState extends Equatable {
  const RoomMemberState({
    required this.members,
    required this.onlineMembers,
    this.selectedMember,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomMemberModel> members;       // قائمة جميع أعضاء الغرفة (تاريخياً أو كلياً)
  final List<RoomMemberModel> onlineMembers; // قائمة الأعضاء المتواجدين حالياً أونلاين بداخل الغرفة
  final RoomMemberModel? selectedMember;     // تفاصيل عضو محدد تم اختياره لعرض ملفه الشخصي
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح قائمة الأعضاء أو الدخول للغرفة لأول مرة
  factory RoomMemberState.initial() {
    return const RoomMemberState(
      members: [],
      onlineMembers: [],
      selectedMember: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الأعضاء بشكل آمن ومطابق تام لقواعد التحديث الفردي
  RoomMemberState copyWith({
    List<RoomMemberModel>? members,
    List<RoomMemberModel>? onlineMembers,
    RoomMemberModel? selectedMember,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomMemberState(
      members: members ?? this.members,
      onlineMembers: onlineMembers ?? this.onlineMembers,
      selectedMember: selectedMember ?? this.selectedMember,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        members,
        onlineMembers,
        selectedMember,
        isLoading,
        errorMessage,
      ];
}
