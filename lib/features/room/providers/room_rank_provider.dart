import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_rank_model.dart';
import 'package:joojo_chat/features/room/repositories/room_rank_repository.dart';

class RoomRankProvider extends ChangeNotifier {
  RoomRankProvider({required RoomRankRepository roomRankRepository}) 
      : _roomRankRepository = roomRankRepository;

  final RoomRankRepository _roomRankRepository;

  List<RoomRankModel> _ranks = [];
  RoomRankModel? _currentUserRank;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomRankModel>>? _rankSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomRankModel> get ranks => _ranks;
  RoomRankModel? get currentUserRank => _currentUserRank;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي والمستمر لقائمة الصدارة داخل الغرفة لمزامنة الهدايا والتنافس (Real-time Stream)
  void listenToRoomRanks({required String roomId, required String rankType}) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _rankSubscription?.cancel();
    _rankSubscription = _roomRankRepository.streamRanks(roomId: roomId, rankType: rankType).listen(
      (rankList) {
        _ranks = rankList;
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

  // جلب قائمة التصنيفات لغرفة معينة بناءً على النوع بشكل يدوي عبر الـ Future
  Future<void> loadRanks({required String roomId, required String rankType, int limit = 50}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _ranks = await _roomRankRepository.getRanks(roomId: roomId, rankType: rankType, limit: limit);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب التصنيف الحالي لمستخدم معين داخل غرفة محددة بناءً على نوع التصنيف
  Future<void> loadUserRank({required String roomId, required String userId, required String rankType}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _currentUserRank = await _roomRankRepository.getUserRank(roomId: roomId, userId: userId, rankType: rankType);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // تحديث نقاط وتفاصيل تصنيف المستخدم أو إنشائه إذا لم يكن موجوداً
  Future<void> saveRank(RoomRankModel rank) async {
    try {
      await _roomRankRepository.upsertRank(rank);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث سكور العضو بشكل تراكمي عند إرسال الهدايا أو التحدث أو الشات
  Future<void> addUserRankScore({
    required String roomId,
    required String userId,
    required String rankType,
    required int scoreIncrement,
    int giftsIncrement = 0,
    int giftValueIncrement = 0,
    int messagesIncrement = 0,
    int speakingTimeIncrement = 0,
  }) async {
    try {
      await _roomRankRepository.incrementRankScore(
        roomId: roomId,
        userId: userId,
        rankType: rankType,
        scoreIncrement: scoreIncrement,
        giftsIncrement: giftsIncrement,
        giftValueIncrement: giftValueIncrement,
        messagesIncrement: messagesIncrement,
        speakingTimeIncrement: speakingTimeIncrement,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إعادة تعيين (تصفير) لوحة الصدارة لغرفة معينة عند تجديد الترتيب
  Future<void> clearRoomRanks({required String roomId, String? rankType}) async {
    try {
      await _roomRankRepository.resetRoomRanks(roomId: roomId, rankType: rankType);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _rankSubscription?.cancel();
    super.dispose();
  }
}
