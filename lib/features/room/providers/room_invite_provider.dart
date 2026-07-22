import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_invite_model.dart';
import 'package:joojo_chat/features/room/repositories/room_invite_repository.dart';

class RoomInviteProvider extends ChangeNotifier {
  RoomInviteProvider({required RoomInviteRepository roomInviteRepository}) 
      : _roomInviteRepository = roomInviteRepository;

  final RoomInviteRepository _roomInviteRepository;

  List<RoomInviteModel> _roomInvites = [];
  List<RoomInviteModel> _sentInvites = [];
  List<RoomInviteModel> _receivedInvites = [];
  RoomInviteModel? _selectedInvite;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomInviteModel>>? _inviteSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomInviteModel> get roomInvites => _roomInvites;
  List<RoomInviteModel> get sentInvites => _sentInvites;
  List<RoomInviteModel> get receivedInvites => _receivedInvites;
  RoomInviteModel? get selectedInvite => _selectedInvite;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي للدعوات المعلقة الواردة للمستخدم لمزامنة التنبيهات فورياً (Real-time Stream)
  void listenToIncomingInvites(String receiverId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _inviteSubscription?.cancel();
    _inviteSubscription = _roomInviteRepository.streamReceivedInvites(receiverId).listen(
      (invitesList) {
        _receivedInvites = invitesList;
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

  // جلب كل الدعوات المرسلة أو المستقبلة الخاصة بغرفة معينة بشكل يدوي عبر الـ Future
  Future<void> loadRoomInvites(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _roomInvites = await _roomInviteRepository.getRoomInvites(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل دعوة محددة بواسطة المعرف الخاص بها
  Future<void> loadInviteDetails(String id) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedInvite = await _roomInviteRepository.getInvite(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إرسال دعوة جديدة للانضمام إلى الغرفة
  Future<String> sendRoomInvitation(RoomInviteModel invite) async {
    try {
      final String id = await _roomInviteRepository.send(invite);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث حالة الدعوة (مثل: accepted, rejected) وتحديث وقت التعديل
  Future<void> changeInviteStatus({required String id, required String status}) async {
    try {
      await _roomInviteRepository.updateStatus(id: id, status: status);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // جلب الدعوات المعلقة (pending) المرسلة بواسطة مستخدم معين بشكل يدوي
  Future<void> loadSentInvites(String senderId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _sentInvites = await _roomInviteRepository.getSentInvites(senderId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب الدعوات المعلقة (pending) الواردة إلى مستخدم معين بشكل يدوي
  Future<void> loadReceivedInvites(String receiverId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _receivedInvites = await _roomInviteRepository.getReceivedInvites(receiverId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // حذف دعوة أو إلغاؤها نهائياً
  Future<void> removeInvitation(String id) async {
    try {
      await _roomInviteRepository.delete(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _inviteSubscription?.cancel();
    super.dispose();
  }
}
