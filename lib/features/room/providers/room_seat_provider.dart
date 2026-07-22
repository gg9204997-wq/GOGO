import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/seat_model.dart';
import 'package:joojo_chat/features/room/repositories/room_seat_repository.dart';

class RoomSeatProvider extends ChangeNotifier {
  RoomSeatProvider({required RoomSeatRepository roomSeatRepository}) 
      : _roomSeatRepository = roomSeatRepository;

  final RoomSeatRepository _roomSeatRepository;

  List<SeatModel> _seats = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<SeatModel> get seats => _seats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ==========================================
  // LOAD ROOM SEATS
  // ==========================================
  Future<void> loadSeats(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _seats = await _roomSeatRepository.getSeats(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // TAKE SEAT (USER TO MIC)
  // ==========================================
  Future<void> occupySeat({
    required String roomId,
    required String userId,
    required int seatNumber,
  }) async {
    try {
      _errorMessage = null;
      
      // استدعاء دالة المستودع بالـ parameters الثلاثة المطابقة لكودك الفعلي تماماً
      await _roomSeatRepository.takeSeat(
        roomId: roomId,
        userId: userId,
        seatNumber: seatNumber,
      );
      
      // تحديث مصفوفة الحالة محلياً فوراً لمنع وميض الشاشة أو التأخير في الـ UI
      final index = _seats.indexWhere((s) => s.seatNumber == seatNumber);
      if (index != -1) {
        _seats[index] = _seats[index].copyWith(
          userId: userId,
          micOn: false,
          isSpeaking: false,
          isMuted: false,
          joinedAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // LEAVE SEAT / VACATE MIC
  // ==========================================
  Future<void> leaveSeat({
    required String roomId,
    required int seatNumber,
  }) async {
    try {
      _errorMessage = null;
      await _roomSeatRepository.leaveSeat(roomId: roomId, seatNumber: seatNumber);
      
      // تفريغ بيانات المقعد محلياً لإزالته من الشاشة في نفس اللحظة
      final index = _seats.indexWhere((s) => s.seatNumber == seatNumber);
      if (index != -1) {
        _seats[index] = _seats[index].copyWith(
          userId: '', // تفريغ الـ ID بناءً على منطق isEmpty الموجود بالموديل
          micOn: false,
          isSpeaking: false,
          isMuted: false,
          joinedAt: null,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // TOGGLE MIC STATUS BY USER
  // ==========================================
  Future<void> changeMicStatus({
    required String roomId,
    required int seatNumber,
    required bool enabled,
  }) async {
    try {
      _errorMessage = null;
      await _roomSeatRepository.toggleMic(roomId: roomId, seatNumber: seatNumber, enabled: enabled);
      
      final index = _seats.indexWhere((s) => s.seatNumber == seatNumber);
      if (index != -1) {
        _seats[index] = _seats[index].copyWith(
          micOn: enabled,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // MUTE USER ON SEAT BY ADMIN
  // ==========================================
  Future<void> changeSeatMute({
    required String roomId,
    required int seatNumber,
    required bool muted,
  }) async {
    try {
      _errorMessage = null;
      await _roomSeatRepository.muteSeat(roomId: roomId, seatNumber: seatNumber, muted: muted);
      
      final index = _seats.indexWhere((s) => s.seatNumber == seatNumber);
      if (index != -1) {
        _seats[index] = _seats[index].copyWith(
          isMuted: muted,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // UPDATE REAL-TIME SPEAKING STATUS
  // ==========================================
  Future<void> changeSpeakingStatus({
    required String roomId,
    required int seatNumber,
    required bool speaking,
  }) async {
    try {
      _errorMessage = null;
      await _roomSeatRepository.updateSpeaking(roomId: roomId, seatNumber: seatNumber, speaking: speaking);
      
      final index = _seats.indexWhere((s) => s.seatNumber == seatNumber);
      if (index != -1) {
        _seats[index] = _seats[index].copyWith(
          isSpeaking: speaking,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ==========================================
  // LOCK / UNLOCK SEAT BY ADMIN
  // ==========================================
  Future<void> changeSeatLock({
    required String roomId,
    required int seatNumber,
    required bool locked,
  }) async {
    try {
      _errorMessage = null;
      await _roomSeatRepository.lockSeat(roomId: roomId, seatNumber: seatNumber, locked: locked);
      
      final index = _seats.indexWhere((s) => s.seatNumber == seatNumber);
      if (index != -1) {
        _seats[index] = _seats[index].copyWith(
          isLocked: locked,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
