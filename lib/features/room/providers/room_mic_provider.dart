import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/mic_request_model.dart';
import 'package:joojo_chat/features/room/repositories/mic_request_repository.dart';

class RoomMicProvider extends ChangeNotifier {
  RoomMicProvider({required MicRequestRepository micRequestRepository}) 
      : _micRequestRepository = micRequestRepository;

  final MicRequestRepository _micRequestRepository;

  List<MicRequestModel> _pendingRequests = [];
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<MicRequestModel>>? _requestsSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<MicRequestModel> get pendingRequests => _pendingRequests;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // الاستماع الفوري والحي لطلبات المايك المعلقة في الغرفة (Real-time Stream)
  void listenToPendingRequests(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _requestsSubscription?.cancel();
    _requestsSubscription = _micRequestRepository.streamPendingRequests(roomId).listen(
      (requestsList) {
        _pendingRequests = requestsList;
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

  // جلب طلبات المايك المعلقة بشكل يدوي عبر الـ Future (مثل التحديث عند السحب لأسفل)
  Future<void> loadPendingRequests(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _pendingRequests = await _micRequestRepository.getPendingRequests(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // تقديم طلب صعود جديد للمايك مع فحص وقائي لمنع التكرار
  Future<void> submitMicRequest(MicRequestModel request) async {
    try {
      final isAlreadyPending = await _micRequestRepository.hasPendingRequest(
        roomId: request.roomId,
        userId: request.userId,
      );
      
      if (!isAlreadyPending) {
        await _micRequestRepository.create(request);
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // معالجة طلب المايك (قبول أو رفض) من قِبل المشرفين والمسؤولين
  Future<void> processMicRequest({
    required String requestId,
    required String status,
    required String handledBy,
  }) async {
    try {
      await _micRequestRepository.handleRequest(id: requestId, status: status, handledBy: handledBy);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // سحب أو إلغاء طلب المايك نهائياً من قِبل العضو نفسه
  Future<void> cancelMicRequest(String requestId) async {
    try {
      await _micRequestRepository.delete(requestId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _requestsSubscription?.cancel();
    super.dispose();
  }
}
