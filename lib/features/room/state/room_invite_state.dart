import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_invite_model.dart';

class RoomInviteState extends Equatable {
  const RoomInviteState({
    required this.roomInvites,
    required this.sentInvites,
    required this.receivedInvites,
    this.selectedInvite,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomInviteModel> roomInvites;     // إجمالي دعوات الغرفة
  final List<RoomInviteModel> sentInvites;     // الدعوات المعلقة المرسلة بواسطة المستخدم
  final List<RoomInviteModel> receivedInvites; // الدعوات المعلقة المستقبلة والواردة للمستخدم
  final RoomInviteModel? selectedInvite;       // تفاصيل دعوة محددة تم اختيارها
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند التعامل مع نظام الدعوات لأول مرة
  factory RoomInviteState.initial() {
    return const RoomInviteState(
      roomInvites: [],
      sentInvites: [],
      receivedInvites: [],
      selectedInvite: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الدعوات بشكل آمن ومطابق تام لقواعد التحديث الفردي
  RoomInviteState copyWith({
    List<RoomInviteModel>? roomInvites,
    List<RoomInviteModel>? sentInvites,
    List<RoomInviteModel>? receivedInvites,
    RoomInviteModel? selectedInvite,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomInviteState(
      roomInvites: roomInvites ?? this.roomInvites,
      sentInvites: sentInvites ?? this.sentInvites,
      receivedInvites: receivedInvites ?? this.receivedInvites,
      selectedInvite: selectedInvite ?? this.selectedInvite,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند زوال الخطأ بنجاح
    );
  }

  @override
  List<Object?> get props => [
        roomInvites,
        sentInvites,
        receivedInvites,
        selectedInvite,
        isLoading,
        errorMessage,
      ];
}
