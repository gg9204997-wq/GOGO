import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_notice_model.dart';
import 'package:joojo_chat/features/room/repositories/room_notice_repository.dart';

class RoomNoticeProvider extends ChangeNotifier {
  RoomNoticeProvider({required RoomNoticeRepository roomNoticeRepository}) 
      : _roomNoticeRepository = roomNoticeRepository;

  final RoomNoticeRepository _roomNoticeRepository;

  List<RoomNoticeModel> _notices = [];
  RoomNoticeModel? _selectedNotice;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomNoticeModel>>? _noticeSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomNoticeModel> get notices => _notices;
  RoomNoticeModel? get selectedNotice => _selectedNotice;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي والتحديث الفوري للإعلانات المعروضة داخل الغرفة لمزامنة لوحة الإعلانات (Real-time Stream)
  void listenToRoomNotices(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _noticeSubscription?.cancel();
    _noticeSubscription = _roomNoticeRepository.streamNotices(roomId).listen(
      (noticeList) {
        _notices = noticeList;
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

  // جلب جميع الإعلانات واللوحات الإرشادية الخاصة بغرفة معينة بشكل يدوي عبر الـ Future
  Future<void> loadNotices(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _notices = await _roomNoticeRepository.getNotices(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب الإعلانات النشطة فقط والتي لم تنتهِ صلاحيتها بعد داخل الغرفة
  Future<void> loadActiveNotices(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _notices = await _roomNoticeRepository.getActiveNotices(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل إعلان محدد بواسطة المعرف الخاص به
  Future<void> loadNoticeDetails(String id) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedNotice = await _roomNoticeRepository.getNotice(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إنشاء أو نشر إعلان جديد داخل الغرفة
  Future<String> publishNotice(RoomNoticeModel notice) async {
    try {
      final String id = await _roomNoticeRepository.create(notice);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث بيانات الإعلان بالكامل وتعديل تاريخ التحديث
  Future<void> updateNoticeDetails(RoomNoticeModel notice) async {
    try {
      await _roomNoticeRepository.update(notice);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تثبيت أو إلغاء تثبيت إعلان معين في أعلى لوحة الغرفة (Pin/Unpin)
  Future<void> changePinStatus({required String id, required bool isPinned}) async {
    try {
      await _roomNoticeRepository.togglePin(id: id, isPinned: isPinned);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تفعيل أو تجميد ظهور الإعلان (Activate/Deactivate)
  Future<void> changeActiveStatus({required String id, required bool isActive}) async {
    try {
      await _roomNoticeRepository.toggleActive(id: id, isActive: isActive);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حذف إعلان نهائياً من الجدول
  Future<void> removeNotice(String id) async {
    try {
      await _roomNoticeRepository.delete(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _noticeSubscription?.cancel();
    super.dispose();
  }
}
