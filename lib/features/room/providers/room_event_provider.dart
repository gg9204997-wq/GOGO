import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_event_model.dart';
import 'package:joojo_chat/features/room/repositories/room_event_repository.dart';

class RoomEventProvider extends ChangeNotifier {
  RoomEventProvider({required RoomEventRepository roomEventRepository}) 
      : _roomEventRepository = roomEventRepository;

  final RoomEventRepository _roomEventRepository;

  List<RoomEventModel> _roomEvents = [];
  RoomEventModel? _selectedEvent;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomEventModel>>? _eventsSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomEventModel> get roomEvents => _roomEvents;
  RoomEventModel? get selectedEvent => _selectedEvent;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // الاستماع المباشر والحي للفعاليات المجدولة داخل الغرفة (Real-time Stream)
  void listenToRoomEvents(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _eventsSubscription?.cancel();
    _eventsSubscription = _roomEventRepository.streamEvents(roomId).listen(
      (eventsList) {
        _roomEvents = eventsList;
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

  // جلب كافة الفعاليات بشكل يدوي عبر الـ Future
  Future<void> loadEvents(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _roomEvents = await _roomEventRepository.getEvents(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب الفعاليات النشطة فقط بشكل يدوي عبر الـ Future
  Future<void> loadActiveEvents(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _roomEvents = await _roomEventRepository.getActiveEvents(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل فعالية محددة عبر معرفها الفريد
  Future<void> loadEventDetails(String id) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedEvent = await _roomEventRepository.getEvent(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إنشاء فعالية أو مسابقة جديدة داخل الغرفة
  Future<String> scheduleNewEvent(RoomEventModel event) async {
    try {
      final String id = await _roomEventRepository.create(event);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث بيانات الفعالية بالكامل
  Future<void> updateEventDetails(RoomEventModel event) async {
    try {
      await _roomEventRepository.update(event);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث حالة الفعالية (مثل: cancelled, completed, active)
  Future<void> changeEventStatus({required String id, required String status}) async {
    try {
      await _roomEventRepository.updateStatus(id: id, status: status);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حذف فعالية نهائياً من الجدول
  Future<void> removeEvent(String id) async {
    try {
      await _roomEventRepository.delete(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // جلب الفعاليات التي تقع في مجال زمني محدد
  Future<void> loadEventsInPeriod({
    required String roomId,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _roomEvents = await _roomEventRepository.getEventsInPeriod(
        roomId: roomId,
        start: start,
        end: end,
      );
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
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _eventsSubscription?.cancel();
    super.dispose();
  }
}
