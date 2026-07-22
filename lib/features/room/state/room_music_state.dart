import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_music_model.dart';

class RoomMusicState extends Equatable {
  const RoomMusicState({
    required this.playlist,
    this.currentPlaying,
    required this.isLoading,
    this.errorMessage,
  });

  final List<RoomMusicModel> playlist;    // قائمة الأغاني والموسيقى المضافة بداخل الغرفة
  final RoomMusicModel? currentPlaying;   // الأغنية أو التراك الذي يعمل حالياً بالواجهة
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند التعامل مع نظام الموسيقى والـ Playlist لأول مرة
  factory RoomMusicState.initial() {
    return const RoomMusicState(
      playlist: [],
      currentPlaying: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الموسيقى بشكل آمن ومطابق تام لقواعد التحديث الفردي
  RoomMusicState copyWith({
    List<RoomMusicModel>? playlist,
    RoomMusicModel? currentPlaying,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomMusicState(
      playlist: playlist ?? this.playlist,
      currentPlaying: currentPlaying ?? this.currentPlaying,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند النجاح وزوال الخطأ
    );
  }

  @override
  List<Object?> get props => [
        playlist,
        currentPlaying,
        isLoading,
        errorMessage,
      ];
}
