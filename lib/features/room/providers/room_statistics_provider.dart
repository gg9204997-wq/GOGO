import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_statistics_model.dart';
import 'package:joojo_chat/features/room/repositories/room_statistics_repository.dart';

class RoomStatisticsProvider extends ChangeNotifier {
  RoomStatisticsProvider({required RoomStatisticsRepository roomStatisticsRepository}) 
      : _statisticsRepository = roomStatisticsRepository;

  final RoomStatisticsRepository _statisticsRepository;

  RoomStatisticsModel? _roomStats;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<RoomStatisticsModel?>? _statsSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  RoomStatisticsModel? get roomStats => _roomStats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ==========================================
  // REAL-TIME STREAM STATISTICS
  // ==========================================
  void listenToRoomStatistics(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _statsSubscription?.cancel();
    _statsSubscription = _statisticsRepository.streamStatistics(roomId).listen(
      (stats) {
        _roomStats = stats;
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

  // ==========================================
  // LOAD STATISTICS VIA FUTURE
  // ==========================================
  Future<void> loadStatistics(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _roomStats = await _statisticsRepository.getStatistics(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // UPSERT STATISTICS
  // ==========================================
  Future<void> saveStatistics(RoomStatisticsModel statistics) async {
    try {
      _errorMessage = null;
      await _statisticsRepository.upsertStatistics(statistics);
      _roomStats = statistics;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // INCREMENT STATISTICS DYNAMICALLY
  // ==========================================
  Future<void> addRoomActivityStats({
    required String roomId,
    int giftsIncrement = 0,
    int coinsIncrement = 0,
    int diamondsIncrement = 0,
    int messagesIncrement = 0,
    int visitorsIncrement = 0,
    int voiceMinutesIncrement = 0,
    int sessionsIncrement = 0,
    int todayGiftsIncrement = 0,
    int todayCoinsIncrement = 0,
    int todayDiamondsIncrement = 0,
  }) async {
    try {
      _errorMessage = null;
      await _statisticsRepository.incrementStatistics(
        roomId: roomId,
        giftsIncrement: giftsIncrement,
        coinsIncrement: coinsIncrement,
        diamondsIncrement: diamondsIncrement,
        messagesIncrement: messagesIncrement,
        visitorsIncrement: visitorsIncrement,
        voiceMinutesIncrement: voiceMinutesIncrement,
        sessionsIncrement: sessionsIncrement,
        todayGiftsIncrement: todayGiftsIncrement,
        todayCoinsIncrement: todayCoinsIncrement,
        todayDiamondsIncrement: todayDiamondsIncrement,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // UPDATE PEAK ONLINE
  // ==========================================
  Future<void> checkAndRefreshPeakOnline({
    required String roomId,
    required int currentOnlineUsers,
  }) async {
    try {
      _errorMessage = null;
      await _statisticsRepository.updatePeakOnline(
        roomId: roomId,
        currentOnlineUsers: currentOnlineUsers,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // RESET DAILY STATISTICS
  // ==========================================
  Future<void> clearDailyStatistics(String roomId) async {
    try {
      _errorMessage = null;
      await _statisticsRepository.resetDailyStatistics(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _statsSubscription?.cancel();
    super.dispose();
  }
}