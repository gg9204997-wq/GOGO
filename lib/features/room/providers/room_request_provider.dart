import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_request_model.dart';
import 'package:joojo_chat/features/room/repositories/room_request_repository.dart';

class RoomRequestProvider extends ChangeNotifier {
  RoomRequestProvider({required RoomRequestRepository roomRequestRepository}) 
      : _roomRequestRepository = roomRequestRepository;

  final RoomRequestRepository _roomRequestRepository;

  List<RoomRequestModel> _roomRequests = [];
  List<RoomRequestModel> _pendingQueueRequests = [];
  RoomRequestModel? _selectedRequest;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomRequestModel>>? _queueSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomRequestModel> get roomRequests => _roomRequests;
  List<RoomRequestModel> get pendingQueueRequests => _pendingQueueRequests;
  RoomRequestModel? get selectedRequest => _selectedRequest;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي واللحظي للطلبات المعلقة داخل الغرفة لكي يراها الـ Admin / Moderator فوراً (Real-time Stream)
  void listenToQueueRequests(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _queueSubscription?.cancel();
    _queueSubscription = _roomRequestRepository.streamPendingRequests(roomId).listen(
      (requestsList) {
        _pendingQueueRequests = requestsList;
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

  // جلب كافة طلبات الغرفة بناءً على معرف الغرفة والحالة يدويًا عبر الـ Future
  Future<void> loadRequests({required String roomId, String status = 'pending'}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _roomRequests = await _roomRequestRepository.getRequests(roomId: roomId, status: status);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل طلب محدد عبر المعرف الخاص به
  Future<void> loadRequestDetails(String id) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedRequest = await _roomRequestRepository.getRequest(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // تقديم طلب جديد داخل الغرفة (مثل طلب الصعود على المقعد المعين) مع فحص وقائي
  Future<String> submitNewRequest(RoomRequestModel request) async {
    try {
      // فحص ما إذا كان للمستخدم طلب معلق حالياً داخل الغرفة لتفادي تكرار الطلبات
      final isPending = await _roomRequestRepository.hasPendingRequest(
        roomId: request.roomId,
        userId: request.userId,
        requestType: request.requestType,
      );

      if (isPending) {
        throw Exception('لديك طلب معلق بالفعل قيد المراجعة');
      }

      final String id = await _roomRequestRepository.create(request);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // معالجة الطلب (قبول أو رفض) وتحديث بيانات المسؤول ووقت المراجعة
  Future<void> processQueueRequest({
    required String requestId,
    required String status,
    required String handledBy,
    String? note,
  }) async {
    try {
      await _roomRequestRepository.handleRequest(
        id: requestId,
        status: status,
        handledBy: handledBy,
        note: note,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // سحب أو إلغاء الطلب من طرف المستخدم نفسه
  Future<void> cancelRequest(String id) async {
    try {
      await _roomRequestRepository.delete(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // فحص مباشر خارجي لحالة الطلب المعلق للمستخدم
  Future<bool> checkHasPendingRequest({
    required String roomId,
    required String userId,
    required String requestType,
  }) async {
    try {
      return await _roomRequestRepository.hasPendingRequest(
        roomId: roomId,
        userId: userId,
        requestType: requestType,
      );
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _queueSubscription?.cancel();
    super.dispose();
  }
}
