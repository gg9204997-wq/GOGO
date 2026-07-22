import 'package:equatable/equatable.dart';
import 'package:joojo_chat/features/room/models/room_game_model.dart';

class RoomGameState extends Equatable {
  const RoomGameState({
    required this.games,
    required this.isLoading,
    this.activeGame,
    this.selectedGame,
    this.errorMessage,
  });

  final List<RoomGameModel> games;
  final RoomGameModel? activeGame;   // اللعبة الجارية أو النشطة حالياً داخل الغرفة
  final RoomGameModel? selectedGame; // تفاصيل لعبة معينة تم اختيارها باللوحة
  final bool isLoading;
  final String? errorMessage;

  // الحالة الابتدائية الافتراضية عند فتح شاشة أو لوحة المسابقات والألعاب الترفيهية
  factory RoomGameState.initial() {
    return const RoomGameState(
      games: [],
      isLoading: false,
      activeGame: null,
      selectedGame: null,
      errorMessage: null,
    );
  }

  // دالة الـ copyWith لضمان تعديل أجزاء حالة الألعاب بشكل آمن دون تدمير مصفوفة الجلسات
  RoomGameState copyWith({
    List<RoomGameModel>? games,
    RoomGameModel? activeGame,
    RoomGameModel? selectedGame,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RoomGameState(
      games: games ?? this.games,
      activeGame: activeGame ?? this.activeGame,
      selectedGame: selectedGame ?? this.selectedGame,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يُمرر مباشرة ليتيح تصفيره بالـ Null عند زوال الخطأ بنجاح
    );
  }

  @override
  List<Object?> get props => [games, activeGame, selectedGame, isLoading, errorMessage];
}
