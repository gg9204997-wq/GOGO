import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_member_model.dart';
import 'package:joojo_chat/features/room/repositories/room_member_repository.dart';

class RoomMemberProvider extends ChangeNotifier {
  RoomMemberProvider({required RoomMemberRepository roomMemberRepository}) 
      : _roomMemberRepository = roomMemberRepository;

  final RoomMemberRepository _roomMemberRepository;

  List<RoomMemberModel> _members = [];
  List<RoomMemberModel> _onlineMembers = [];
  RoomMemberModel? _selectedMember;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomMemberModel>>? _membersSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomMemberModel> get members => _members;
  List<RoomMemberModel> get onlineMembers => _onlineMembers;
  RoomMemberModel? get selectedMember => _selectedMember;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي للأعضاء المتواجدين أونلاين لمزامنة المايكات والمقاعد فورياً (Real-time Stream)
  void listenToRoomMembers(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _membersSubscription?.cancel();
    _membersSubscription = _roomMemberRepository.streamMembers(roomId).listen(
      (membersList) {
        _onlineMembers = membersList;
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

  // جلب جميع الأعضاء الحاليين داخل غرفة معينة بشكل يدوي عبر الـ Future
  Future<void> loadMembers(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _members = await _roomMemberRepository.getMembers(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب قائمة الأعضاء المتواجدين أونلاين فقط بشكل يدوي عبر الـ Future
  Future<void> loadOnlineMembers(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _onlineMembers = await _roomMemberRepository.getOnlineMembers(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب بيانات عضو محدد داخل غرفة معينة بواسطة معرف الغرفة والمستخدم
  Future<void> loadMemberDetails({required String roomId, required String userId}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedMember = await _roomMemberRepository.getMember(roomId: roomId, userId: userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إضافة مستخدم جديد كعضو في الغرفة عند الدخول
  Future<String> joinRoom(RoomMemberModel member) async {
    try {
      final String id = await _roomMemberRepository.join(member);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث بيانات العضو بالكامل
  Future<void> updateMemberInfo(RoomMemberModel member) async {
    try {
      await _roomMemberRepository.update(member);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث حالة الاتصال وهل المستخدم متواجد بالاتصال أم غادر الغرفة
  Future<void> changeOnlineStatus({required String id, required bool isOnline}) async {
    try {
      await _roomMemberRepository.updateOnlineStatus(id: id, isOnline: isOnline);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حجز أو تغيير مقعد العضو (Seat Management)
  Future<void> changeMemberSeat({required String id, required int? seatNumber}) async {
    try {
      await _roomMemberRepository.updateSeat(id: id, seatNumber: seatNumber);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // كتم أو تفعيل صوت العضو (Mute/Unmute) من قِبل الإدارة والمشرفين
  Future<void> changeMuteState({required String id, required bool isMuted}) async {
    try {
      await _roomMemberRepository.toggleMute(id: id, isMuted: isMuted);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تفعيل أو غلق المايك من طرف العضو نفسه المتواجد على مقعد التحدث
  Future<void> changeMicState({required String id, required bool micEnabled}) async {
    try {
      await _roomMemberRepository.toggleMic(id: id, micEnabled: micEnabled);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث محفظة الدعم والعملات التراكمية المرسلة من العضو داخل الغرفة
  Future<void> addMemberContributions({
    required String id,
    required int additionalDiamonds,
    required int additionalCoins,
  }) async {
    try {
      await _roomMemberRepository.incrementContributions(
        id: id,
        additionalDiamonds: additionalDiamonds,
        additionalCoins: additionalCoins,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _membersSubscription?.cancel();
    super.dispose();
  }
}
