import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_moderator_model.dart';
import 'package:joojo_chat/features/room/repositories/room_moderator_repository.dart';

class RoomModeratorProvider extends ChangeNotifier {
  RoomModeratorProvider({required RoomModeratorRepository roomModeratorRepository}) 
      : _moderatorRepository = roomModeratorRepository;

  final RoomModeratorRepository _moderatorRepository;

  List<RoomModeratorModel> _moderators = [];
  List<RoomModeratorModel> _activeModerators = [];
  List<RoomModeratorModel> _expiredModerators = [];
  RoomModeratorModel? _selectedModerator;
  int _moderatorsCount = 0;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomModeratorModel>>? _moderatorsSubscription;
  StreamSubscription<RoomModeratorModel?>? _singleModeratorSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomModeratorModel> get moderators => _moderators;
  List<RoomModeratorModel> get activeModerators => _activeModerators;
  List<RoomModeratorModel> get expiredModerators => _expiredModerators;
  RoomModeratorModel? get selectedModerator => _selectedModerator;
  int get moderatorsCount => _moderatorsCount;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي والمستمر لجميع مشرفي الغرفة مرتبين زمنياً (Real-time Stream)
  void listenToRoomModerators(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _moderatorsSubscription?.cancel();
    _moderatorsSubscription = _moderatorRepository.streamModerators(roomId).listen(
      (moderatorsList) {
        _moderators = moderatorsList;
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

  // البث الحي لتحديثات مشرف واحد محدد داخل الغرفة (Real-time Stream)
  void listenToSingleModerator({required String roomId, required String userId}) {
    _singleModeratorSubscription?.cancel();
    _singleModeratorSubscription = _moderatorRepository.streamModerator(roomId: roomId, userId: userId).listen(
      (moderatorData) {
        _selectedModerator = moderatorData;
        notifyListeners();
      },
      onError: (Object error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // جلب كافة المشرفين بشكل يدوي عبر الـ Future
  Future<void> loadModerators(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _moderators = await _moderatorRepository.getModerators(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل مشرف محدد بواسطة معرف الغرفة والمستخدم
  Future<void> loadModerator({required String roomId, required String userId}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedModerator = await _moderatorRepository.getModerator(roomId: roomId, userId: userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // تعيين وتثبيت مشرف جديد داخل الغرفة
  Future<String> createModerator(RoomModeratorModel moderator) async {
    try {
      final String id = await _moderatorRepository.create(moderator);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث كائن المشرف بالكامل
  Future<void> updateModeratorInfo(RoomModeratorModel moderator) async {
    try {
      await _moderatorRepository.update(moderator);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حذف مشرف نهائياً من اللوحة
  Future<void> removeModerator(String id) async {
    try {
      await _moderatorRepository.delete(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تفعيل حساب المشرف
  Future<void> activateModerator(String id) async {
    try {
      await _moderatorRepository.activate(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إلغاء تفعيل وتجميد صلاحيات المشرف مؤقتاً
  Future<void> deactivateModerator(String id) async {
    try {
      await _moderatorRepository.deactivate(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث الرول البرمجي أو المسمى الوظيفي للمشرف
  Future<void> changeModeratorRole({required String id, required String role}) async {
    try {
      await _moderatorRepository.updateRole(id: id, role: role);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تعديل وتخصيص صلاحيات المشرف الفردية
  Future<void> changeModeratorPermissions({required String id, required Map<String, dynamic> permissions}) async {
    try {
      await _moderatorRepository.updatePermissions(id: id, permissions: permissions);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // سحب وإلغاء رتبة الإشراف مع تحديد المسؤول عن الإلغاء
  Future<void> revokeModerator({required String id, required String revokedBy}) async {
    try {
      await _moderatorRepository.revoke(id: id, revokedBy: revokedBy);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تمديد فترة صلاحية الإشراف للمشرفين المؤقتين
  Future<void> extendModeratorPeriod({required String id, DateTime? expiresAt}) async {
    try {
      await _moderatorRepository.extend(id: id, expiresAt: expiresAt);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // التحقق من وجود مستخدم محدد في طاقم الإشراف للغرفة
  Future<bool> checkIfModeratorExists({required String roomId, required String userId}) async {
    try {
      return await _moderatorRepository.exists(roomId: roomId, userId: userId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // تحديث وحساب عدد المشرفين الإجمالي داخل الغرفة
  Future<void> refreshModeratorsCount(String roomId) async {
    try {
      _moderatorsCount = await _moderatorRepository.count(roomId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // جلب قائمة المشرفين النشطين حالياً عبر الـ Future
  Future<void> loadActiveModerators(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _activeModerators = await _moderatorRepository.getActiveModerators(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب قائمة المشرفين الذين يمتلكون تاريخ انتهاء محدد
  Future<void> loadExpiredModerators(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _expiredModerators = await _moderatorRepository.getExpiredModerators(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريمات فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _moderatorsSubscription?.cancel();
    _singleModeratorSubscription?.cancel();
    super.dispose();
  }
}
