import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_model.dart';

class RoomState extends Equatable {
  const RoomState({
    this.currentRoom,
    required this.rooms,
    required this.ownerRooms,
    required this.searchResults,
    required this.officialRooms,
    required this.recommendedRooms,
    required this.categoryRooms,
    required this.countryRooms,
    required this.languageRooms,
    required this.hotRooms,
    required this.newestRooms,
    required this.totalRoomsCount,
    required this.isLoading,
    this.errorMessage,
  });

  final RoomModel? currentRoom;              // الغرفة الصوتية المفتوحة حالياً بالواجهة
  final List<RoomModel> rooms;               // القائمة العامة للغرف بنظام الـ Pagination
  final List<RoomModel> ownerRooms;          // غرف المالك المستعلم عنها
  final List<RoomModel> searchResults;       // نتائج البحث النصي عن الغرف
  final List<RoomModel> officialRooms;       // غرف المنصة الرسمية الموثقة
  final List<RoomModel> recommendedRooms;    // الغرف الموصى بها للمستخدم
  final List<RoomModel> categoryRooms;       // الغرف التابعة لتصنيف وفئة معينة
  final List<RoomModel> countryRooms;        // الغرف التابعة لدولة معينة
  final List<RoomModel> languageRooms;       // الغرف التابعة للغة معينة
  final List<RoomModel> hotRooms;            // الغرف الأكثر شعبية وحرارة (Hot)
  final List<RoomModel> newestRooms;         // أحدث الغرف التي تم إنشاؤها مؤخراً
  final int totalRoomsCount;                 // العدد الإجمالي الكلي للغرف
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح شاشات استكشاف الغرف أو الدخول لأول مرة
  factory RoomState.initial() {
    return const RoomState(
      currentRoom: null,
      rooms: [],
      ownerRooms: [],
      searchResults: [],
      officialRooms: [],
      recommendedRooms: [],
      categoryRooms: [],
      countryRooms: [],
      languageRooms: [],
      hotRooms: [],
      newestRooms: [],
      totalRoomsCount: 0,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء واجهة مستعرض الغرف والإدارة دون تدمير مصفوفات التصنيفات المستقرة
  RoomState copyWith({
    RoomModel? currentRoom,
    List<RoomModel>? rooms,
    List<RoomModel>? ownerRooms,
    List<RoomModel>? searchResults,
    List<RoomModel>? officialRooms,
    List<RoomModel>? recommendedRooms,
    List<RoomModel>? categoryRooms,
    List<RoomModel>? countryRooms,
    List<RoomModel>? languageRooms,
    List<RoomModel>? hotRooms,
    List<RoomModel>? newestRooms,
    int? totalRoomsCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomState(
      currentRoom: currentRoom ?? this.currentRoom,
      rooms: rooms ?? this.rooms,
      ownerRooms: ownerRooms ?? this.ownerRooms,
      searchResults: searchResults ?? this.searchResults,
      officialRooms: officialRooms ?? this.officialRooms,
      recommendedRooms: recommendedRooms ?? this.recommendedRooms,
      categoryRooms: categoryRooms ?? this.categoryRooms,
      countryRooms: countryRooms ?? this.countryRooms,
      languageRooms: languageRooms ?? this.languageRooms,
      hotRooms: hotRooms ?? this.hotRooms,
      newestRooms: newestRooms ?? this.newestRooms,
      totalRoomsCount: totalRoomsCount ?? this.totalRoomsCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        currentRoom,
        rooms,
        ownerRooms,
        searchResults,
        officialRooms,
        recommendedRooms,
        categoryRooms,
        countryRooms,
        languageRooms,
        hotRooms,
        newestRooms,
        totalRoomsCount,
        isLoading,
        errorMessage,
      ];
}
