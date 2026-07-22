import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_user_model.dart';
import 'package:joojo_chat/features/room/repositories/room_user_repository.dart';

class RoomUsersProvider extends ChangeNotifier {
  RoomUsersProvider({required RoomUserRepository roomUserRepository}) 
      : _roomUserRepository = roomUserRepository;

  final RoomUserRepository _roomUserRepository;

  List<RoomUserModel> _activeUsers = [];
  RoomUserModel? _selectedRoomUser;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomUserModel>>? _usersSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomUserModel> get activeUsers => _activeUsers;
  RoomUserModel? get selectedRoomUser => _selectedRoomUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ==========================================
  // REAL-TIME STREAM ACTIVE USERS
  // ==========================================
  void listenToActiveUsers(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _usersSubscription?.cancel();
    _usersSubscription = _roomUserRepository.streamActiveUsers(roomId).listen(
      (usersList) {
        _activeUsers = usersList;
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
  // LOAD ACTIVE USERS VIA FUTURE
  // ==========================================
  Future<void> loadActiveUsers(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _activeUsers = await _roomUserRepository.getActiveUsers(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // LOAD SPECIFIC ROOM USER DETAILS
  // ==========================================
  Future<void> loadRoomUserDetails({required String roomId, required String userId}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedRoomUser = await _roomUserRepository.getRoomUser(roomId: roomId, userId: userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // SAVE / UPSERT ROOM USER (JOIN ROOM)
  // ==========================================
  Future<void> joinRoom(RoomUserModel roomUser) async {
    try {
      _errorMessage = null;
      await _roomUserRepository.saveRoomUser(roomUser);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // UPDATE USER ROLE & MANAGEMENT PERMISSIONS
  // ==========================================
  Future<void> changeUserRole({
    required String roomId,
    required String userId,
    required String role,
    required bool isModerator,
    required bool isOwner,
  }) async {
    try {
      _errorMessage = null;
      await _roomUserRepository.updateUserRole(
        roomId: roomId,
        userId: userId,
        role: role,
        isModerator: isModerator,
        isOwner: isOwner,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // UPDATE MUTE STATUS (MUTE / UNMUTE)
  // ==========================================
  Future<void> changeMuteStatus({
    required String roomId,
    required String userId,
    required bool isMuted,
  }) async {
    try {
      _errorMessage = null;
      await _roomUserRepository.updateMuteStatus(
        roomId: roomId,
        userId: userId,
        isMuted: isMuted,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // UPDATE BAN STATUS (BAN / UNBAN)
  // ==========================================
  Future<void> changeBanStatus({
    required String roomId,
    required String userId,
    required bool isBanned,
  }) async {
    try {
      _errorMessage = null;
      await _roomUserRepository.updateBanStatus(
        roomId: roomId,
        userId: userId,
        isBanned: isBanned,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // UPDATE SEAT NUMBER
  // ==========================================
  Future<void> changeSeatNumber({
    required String roomId,
    required String userId,
    required int seatNumber,
  }) async {
    try {
      _errorMessage = null;
      await _roomUserRepository.updateSeatNumber(
        roomId: roomId,
        userId: userId,
        seatNumber: seatNumber,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // LEAVE ROOM (DELETE RECORD)
  // ==========================================
  Future<void> exitRoom({required String roomId, required String userId}) async {
    try {
      _errorMessage = null;
      await _roomUserRepository.leaveRoom(roomId: roomId, userId: userId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _usersSubscription?.cancel();
    super.dispose();
  }
}
