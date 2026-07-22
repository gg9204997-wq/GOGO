import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_background_model.dart';

class RoomBackgroundState extends Equatable {
  const RoomBackgroundState({
    required this.backgrounds,
    required this.isLoading,
    this.selectedBackground,
    this.activeBackground,
    this.errorMessage,
  });

  final List<RoomBackgroundModel> backgrounds;
  final RoomBackgroundModel? selectedBackground;
  final RoomBackgroundModel? activeBackground; // الخلفية النشطة المعروضة حالياً بالواجهة
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح لوحة ثيمات الخلفيات لأول مرة
  factory RoomBackgroundState.initial() {
    return const RoomBackgroundState(
      backgrounds: [],
      isLoading: false,
      selectedBackground: null,
      activeBackground: null,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith الصارمة لتحديث أجزاء حالة الخلفية بشكل آمن دون تدمير بقية البيانات
  RoomBackgroundState copyWith({
    List<RoomBackgroundModel>? backgrounds,
    RoomBackgroundModel? selectedBackground,
    RoomBackgroundModel? activeBackground,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomBackgroundState(
      backgrounds: backgrounds ?? this.backgrounds,
      selectedBackground: selectedBackground ?? this.selectedBackground,
      activeBackground: activeBackground ?? this.activeBackground,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يتم تمريره مباشرة لتسهيل تصفيره (Null) عند النجاح
    );
  }

  @override
  List<Object?> get props => [
        backgrounds,
        selectedBackground,
        activeBackground,
        isLoading,
        errorMessage,
      ];
}
