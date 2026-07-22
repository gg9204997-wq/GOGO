import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_level_history_model.dart';
import 'package:joojo_chat/features/room/repositories/room_level_repository.dart';

class RoomLevelHistoryProvider extends ChangeNotifier {
  RoomLevelHistoryProvider({required RoomLevelRepository roomLevelRepository}) 
      : _roomLevelRepository = roomLevelRepository;

  final RoomLevelRepository _roomLevelRepository;

  List<RoomLevelHistoryModel> _levelHistory = [];
  RoomLevelHistoryModel? _latestLevel;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomLevelHistoryModel> get levelHistory => _levelHistory;
  RoomLevelHistoryModel? get latestLevel => _latestLevel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // جلب سجل ترقيات مستويات الغرفة بالكامل عبر الـ Future
  Future<void> loadLevelHistory(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _levelHistory = await _roomLevelRepository.getHistory(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب آخر مستوى وصلت إليه الغرفة
  Future<void> loadLatestLevel(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _latestLevel = await _roomLevelRepository.getLatestLevel(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // تسجيل ترقية أو سجل جديد لمستوى الغرفة
  Future<void> logNewLevel(RoomLevelHistoryModel history) async {
    try {
      _errorMessage = null;
      await _roomLevelRepository.addHistory(history);
      
      // تحديث الحالة محلياً فوراً لمنح المستخدم تجربة سريعة في الواجهة
      _levelHistory.insert(0, history);
      _latestLevel = history;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إضافة نقاط خبرة (XP) وتعديل المستوى التابع للغرفة
  Future<void> addRoomXp({
    required String roomId,
    required int oldLevel,
    required int newLevel,
    required int xp,
    String? reason,
    String? createdBy,
  }) async {
    try {
      _errorMessage = null;
      await _roomLevelRepository.addXp(
        roomId: roomId,
        oldLevel: oldLevel,
        newLevel: newLevel,
        xp: xp,
        reason: reason,
        createdBy: createdBy,
      );
      
      // بعد إضافة الـ XP بنجاح نقوم بإعادة تحديث السجلات آلياً لمزامنة الأرقام الجديدة
      await loadLatestLevel(roomId);
      await loadLevelHistory(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حذف سجل معين من تاريخ مستويات الغرفة بواسطة المعرف
  Future<void> removeHistoryRecord(String id) async {
    try {
      _errorMessage = null;
      await _roomLevelRepository.deleteHistory(id);
      
      _levelHistory.removeWhere((record) => record.id == id);
      if (_latestLevel?.id == id) {
        _latestLevel = _levelHistory.isNotEmpty ? _levelHistory.first : null;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
