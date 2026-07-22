// ==========================================
// الجزء الأول: الـ VARIABLES والـ STREAMS ودوال الجلب والبحث
// ==========================================

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_model.dart';
import 'package:joojo_chat/features/room/repositories/room_repository.dart';

class RoomProvider extends ChangeNotifier {
  RoomProvider({required RoomRepository roomRepository}) : _roomRepository = roomRepository;

  final RoomRepository _roomRepository;

  RoomModel? _currentRoom;
  List<RoomModel> _rooms = [];
  List<RoomModel> _ownerRooms = [];
  List<RoomModel> _searchResults = [];
  List<RoomModel> _officialRooms = [];
  List<RoomModel> _recommendedRooms = [];
  List<RoomModel> _categoryRooms = [];
  List<RoomModel> _countryRooms = [];
  List<RoomModel> _languageRooms = [];
  List<RoomModel> _hotRooms = [];
  List<RoomModel> _newestRooms = [];
  int _totalRoomsCount = 0;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<RoomModel?>? _roomSubscription;
  StreamSubscription<List<RoomModel>>? _roomsSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  RoomModel? get currentRoom => _currentRoom;
  List<RoomModel> get rooms => _rooms;
  List<RoomModel> get ownerRooms => _ownerRooms;
  List<RoomModel> get searchResults => _searchResults;
  List<RoomModel> get officialRooms => _officialRooms;
  List<RoomModel> get recommendedRooms => _recommendedRooms;
  List<RoomModel> get categoryRooms => _categoryRooms;
  List<RoomModel> get countryRooms => _countryRooms;
  List<RoomModel> get languageRooms => _languageRooms;
  List<RoomModel> get hotRooms => _hotRooms;
  List<RoomModel> get newestRooms => _newestRooms;
  int get totalRoomsCount => _totalRoomsCount;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي لتغيرات غرفة محددة (Real-time Stream)
  void listenToRoom(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _roomSubscription?.cancel();
    _roomSubscription = _roomRepository.streamRoom(roomId).listen(
      (roomData) {
        _currentRoom = roomData;
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

  // البث الحي لجميع الغرف (Real-time Stream)
  void listenToAllRooms() {
    _roomsSubscription?.cancel();
    _roomsSubscription = _roomRepository.streamRooms().listen(
      (roomsList) {
        _rooms = roomsList;
        notifyListeners();
      },
      onError: (Object error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // جلب الغرف العامة بنظام الصفحات والـ Pagination
  Future<void> loadRooms({int page = 0, int limit = 20}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _rooms = await _roomRepository.getRooms(page: page, limit: limit);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل غرفة بالـ ID
  Future<RoomModel?> fetchRoomById(String roomId) async {
    try {
      return await _roomRepository.getRoomById(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // جلب تفاصيل غرفة بالرقم الظاهري
  Future<RoomModel?> fetchRoomByNumber(int roomNumber) async {
    try {
      return await _roomRepository.getRoomByNumber(roomNumber);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // جلب غرف المالك
  Future<void> loadRoomsByOwner(String ownerId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _ownerRooms = await _roomRepository.getRoomsByOwner(ownerId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // البحث عن الغرف بالاسم
  Future<void> searchForRooms(String keyword) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _searchResults = await _roomRepository.searchRooms(keyword);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب الغرف الرسمية
  Future<void> loadOfficialRooms() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _officialRooms = await _roomRepository.getOfficialRooms();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب الغرف الموصى بها
  Future<void> loadRecommendedRooms() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _recommendedRooms = await _roomRepository.getRecommendedRooms();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب غرف تابعة لتصنيف معين
  Future<void> loadCategoryRooms(String category) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _categoryRooms = await _roomRepository.getCategoryRooms(category);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب غرف تابعة لدولة معينة
  Future<void> loadCountryRooms(String country) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _countryRooms = await _roomRepository.getCountryRooms(country);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب غرف تابعة للغة معينة
  Future<void> loadLanguageRooms(String language) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _languageRooms = await _roomRepository.getLanguageRooms(language);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب الغرف الأكثر شعبية (Hot)
  Future<void> loadHotRooms({int limit = 20}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _hotRooms = await _roomRepository.getHotRooms(limit: limit);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب أحدث الغرف إنشاءً
  Future<void> loadNewestRooms({int limit = 20}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _newestRooms = await _roomRepository.getNewestRooms(limit: limit);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
// ==========================================
// الجزء الثاني: دوال الإنشاء، التحديث، التحكم، والـ DISPOSE
// ==========================================

  // إنشاء غرفة جديدة
  Future<String> createNewRoom(RoomModel room) async {
    try {
      final String id = await _roomRepository.createRoom(room);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث الغرفة بالكامل
  Future<void> updateRoomData(RoomModel room) async {
    try {
      await _roomRepository.updateRoom(room);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حذف غرفة نهائياً
  Future<void> removeRoom(String roomId) async {
    try {
      await _roomRepository.deleteRoom(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث لوحة الإعلانات
  Future<void> updateRoomAnnouncement(String roomId, String? announcement) async {
    try {
      await _roomRepository.updateAnnouncement(roomId: roomId, announcement: announcement);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث غلاف الغرفة
  Future<void> updateRoomCover(String roomId, String? roomCover) async {
    try {
      await _roomRepository.updateCover(roomId: roomId, roomCover: roomCover);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث خلفية الغرفة
  Future<void> updateRoomBackground(String roomId, String? roomBackground) async {
    try {
      await _roomRepository.updateBackground(roomId: roomId, roomBackground: roomBackground);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث عدد المستخدمين النشطين
  Future<void> updateRoomActiveUsers(String roomId, int activeUsers) async {
    try {
      await _roomRepository.updateActiveUsers(roomId: roomId, activeUsers: activeUsers);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث شعبية الغرفة (Heat)
  Future<void> updateRoomHeatValue(String roomId, int heat) async {
    try {
      await _roomRepository.updateHeat(roomId: roomId, heat: heat);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث مستوى الغرفة
  Future<void> updateRoomLevelValue(String roomId, int roomLevel) async {
    try {
      await _roomRepository.updateRoomLevel(roomId: roomId, roomLevel: roomLevel);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // قفل الغرفة برقم سري
  Future<void> lockCurrentRoom({required String roomId, required String password}) async {
    try {
      await _roomRepository.lockRoom(roomId: roomId, password: password);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إلغاء قفل الغرفة
  Future<void> unlockCurrentRoom(String roomId) async {
    try {
      await _roomRepository.unlockRoom(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إغلاق الغرفة منطقياً
  Future<void> closeCurrentRoom(String roomId) async {
    try {
      await _roomRepository.closeRoom(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إعادة فتح الغرفة المغلقة
  Future<void> reopenCurrentRoom(String roomId) async {
    try {
      await _roomRepository.reopenRoom(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // التحقق من وجود الغرفة
  Future<bool> checkRoomExists(String roomId) async {
    try {
      return await _roomRepository.exists(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // حساب العدد الإجمالي للغرف
  Future<void> refreshRoomsCount() async {
    try {
      _totalRoomsCount = await _roomRepository.countRooms();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _roomSubscription?.cancel();
    _roomsSubscription?.cancel();
    super.dispose();
  }
}
