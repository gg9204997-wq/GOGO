import 'package:joojo_chat/features/room/models/room_game_model.dart';

class RoomGameService {
  // التحقق مما إذا كان المستخدم موجوداً حالياً في قائمة اللاعبين المشاركين في الجلسة
  bool isUserInGame({required String userId, required RoomGameModel? game}) {
    if (game == null) return false;
    
    // فحص مصفوفة الـ players؛ حيث يمكن أن تحتوي على معرفات نصية أو خرائط مستخدمين
    return game.players.any((player) {
      if (player is String) {
        return player == userId;
      } else if (player is Map) {
        return player['user_id']?.toString() == userId;
      }
      return false;
    });
  }

  // فحص شروط أهلية انضمام المستخدم للعبة بناءً على الحد الأقصى للاعبين في الإعدادات وحالة الجلسة
  bool canJoinGame({required String userId, required RoomGameModel? game}) {
    if (game == null) return false;
    
    // لا يمكن الانضمام إذا كانت اللعبة بدأت بالفعل أو انتهت
    if (game.status != 'waiting') return false;

    // إذا كان المستخدم مسجلاً مسبقاً، لا داعي لإعادة الفحص
    if (isUserInGame(userId: userId, game: game)) return true;

    // جلب الحد الأقصى المسموح به من الخريطة settings (افتراضياً 4 لاعبين مثلاً)
    final maxPlayers = (game.settings['max_players'] as num?)?.toInt() ?? 4;
    
    return game.players.length < maxPlayers;
  }

  // صياغة وعرض اسم اللعبة الحالي المختار للـ UI بناءً على الـ game_type أو الـ title
  String getGameDisplayName(RoomGameModel game) {
    if (game.title != null && game.title!.isNotEmpty) {
      return game.title!;
    }
    
    // تحويل نوع اللعبة لاسم مقروء ومفهوم للمستخدم
    switch (game.gameType) {
      case 'ludo':
        return 'لعبة لودو المشوقة';
      case 'domino':
        return 'لعبة الدومينو الفورية';
      case 'uno':
        return 'تحدي كروت الأونو';
      default:
        return 'جلسة ترفيه ومسابقات';
    }
  }
}
