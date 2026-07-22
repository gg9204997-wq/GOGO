import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_ban_model.dart';
import 'package:joojo_chat/features/room/repositories/room_ban_repository.dart';

class RoomAdminProvider extends ChangeNotifier {
  RoomAdminProvider({required RoomBanRepository roomBanRepository}) 
      : _roomBanRepository = roomBanRepository;

  final RoomBanRepository _roomBanRepository;

  List<RoomBanModel> _roomBans = [];
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomBanModel>>? _bansSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomBanModel> get roomBans => _roomBans;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // الاستماع المباشر والحي لقائمة عمليات الحظر داخل الغرفة (Real-time Stream)
  void listenToRoomBans(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _bansSubscription?.cancel();
    _bansSubscription = _roomBanRepository.streamBans(roomId).listen(
      (bansList) {
        _roomBans = bansList;
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

  // جلب كافة عمليات الحظر بشكل يدوي عبر الـ Future
  Future<void> loadBans(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _roomBans = await _roomBanRepository.getBans(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب قائمة الحظر النشطة فقط بشكل يدوي عبر الـ Future
  Future<void> loadActiveBans(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _roomBans = await _roomBanRepository.getActiveBans(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // تنفيذ عملية حظر مستخدم جديد داخل الغرفة
  Future<String> banUser(RoomBanModel banDetails) async {
    try {
      final String id = await _roomBanRepository.ban(banDetails);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // فك الحظر وإلغاؤه عن مستخدم معين
  Future<void> liftUserBan({required String id, required String liftedBy}) async {
    try {
      await _roomBanRepository.liftBan(id: id, liftedBy: liftedBy);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // فحص وقائي سريع لحالة حظر المستخدم الحالي قبل السماح له بدخول شاشة الغرفة
  Future<bool> checkUserIsBanned({required String roomId, required String userId}) async {
    try {
      return await _roomBanRepository.isUserBanned(roomId: roomId, userId: userId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // تحديث بيانات سجل الحظر بالكامل
  Future<void> updateBanDetails(RoomBanModel banDetails) async {
    try {
      await _roomBanRepository.update(banDetails);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _bansSubscription?.cancel();
    super.dispose();
  }
}
