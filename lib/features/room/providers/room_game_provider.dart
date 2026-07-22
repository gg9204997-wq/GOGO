import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_game_model.dart';
import 'package:joojo_chat/features/room/repositories/room_game_repository.dart';

class RoomGameProvider extends ChangeNotifier {
  RoomGameProvider({required RoomGameRepository roomGameRepository}) 
      : _roomGameRepository = roomGameRepository;

  final RoomGameRepository _roomGameRepository;

  List<RoomGameModel> _games = [];
  RoomGameModel? _activeGame;
  RoomGameModel? _selectedGame;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomGameModel>>? _gamesSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomGameModel> get games => _games;
  RoomGameModel? get activeGame => _activeGame;
  RoomGameModel? get selectedGame => _selectedGame;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // الاستماع البثي الحي والمباشر لحالة الألعاب داخل غرفة معينة لمزامنة اللاعبين فورياً (Real-time Stream)
  void listenToGames(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _gamesSubscription?.cancel();
    _gamesSubscription = _roomGameRepository.streamGames(roomId).listen(
      (gamesList) {
        _games = gamesList;
        
        // استخراج اللعبة النشطة تلقائياً من قائمة الألعاب الجارية للتسهيل على واجهة المستخدم
        final active = gamesList.where((g) => g.status == 'waiting' || g.status == 'running');
        _activeGame = active.isNotEmpty ? active.first : null;
        
        _isLoading = false;
        notifyListeners();
      },
      onError: (Object error) {
        _errorMessage = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  // جلب كل الألعاب التي تمت أو تجري داخل غرفة معينة يدويًا عبر الـ Future
  Future<void> loadGames(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _games = await _roomGameRepository.getGames(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب اللعبة النشطة أو الجارية حالياً داخل الغرفة بشكل يدوي
  Future<void> loadActiveGame(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _activeGame = await _roomGameRepository.getActiveGame(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل لعبة محددة بواسطة المعرف الخاص بها
  Future<void> loadGameDetails(String id) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedGame = await _roomGameRepository.getGame(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إنشاء لعبة جديدة داخل الغرفة
  Future<String> createNewGame(RoomGameModel game) async {
    try {
      final String id = await _roomGameRepository.create(game);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // بدء اللعبة وتغيير حالتها إلى running وتحديث وقت البدء
  Future<void> beginGame(String id) async {
    try {
      await _roomGameRepository.startGame(id: id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إنهاء اللعبة وتحديد الفائز وتغيير الحالة إلى finished وتحديث وقت النهاية
  Future<void> completeGame({required String id, required String? winnerId}) async {
    try {
      await _roomGameRepository.finishGame(id: id, winnerId: winnerId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث قائمة اللاعبين الحاليين داخل اللعبة (انضمام أو مغادرة)
  Future<void> changePlayers({required String id, required List<dynamic> players}) async {
    try {
      await _roomGameRepository.updatePlayers(id: id, players: players);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث إعدادات اللعبة أثناء مرحلة الانتظار
  Future<void> changeSettings({required String id, required Map<String, dynamic> settings}) async {
    try {
      await _roomGameRepository.updateSettings(id: id, settings: settings);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إلغاء اللعبة وحذفها نهائياً
  Future<void> removeGame(String id) async {
    try {
      await _roomGameRepository.delete(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _gamesSubscription?.cancel();
    super.dispose();
  }
}
