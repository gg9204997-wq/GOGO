import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_message_model.dart';
import 'package:joojo_chat/features/room/repositories/room_message_repository.dart';

class RoomChatProvider extends ChangeNotifier {
  RoomChatProvider({required RoomMessageRepository roomMessageRepository}) 
      : _messageRepository = roomMessageRepository;

  final RoomMessageRepository _messageRepository;

  List<RoomMessageModel> _messages = [];
  List<RoomMessageModel> _userMessages = [];
  List<RoomMessageModel> _systemMessages = [];
  RoomMessageModel? _selectedMessage;
  int _messageCount = 0;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomMessageModel>>? _messagesSubscription;
  StreamSubscription<RoomMessageModel?>? _singleMessageSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomMessageModel> get messages => _messages;
  List<RoomMessageModel> get userMessages => _userMessages;
  List<RoomMessageModel> get systemMessages => _systemMessages;
  RoomMessageModel? get selectedMessage => _selectedMessage;
  int get messageCount => _messageCount;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي والمستمر لرسائل الغرفة غير المحذوفة مرتبة زمنياً (Real-time Stream)
  void listenToRoomMessages(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _messagesSubscription?.cancel();
    _messagesSubscription = _messageRepository.streamMessages(roomId).listen(
      (messagesList) {
        _messages = messagesList;
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

  // البث الحي لتحديثات رسالة واحدة محددة (Real-time Stream)
  void listenToSingleMessage(String id) {
    _singleMessageSubscription?.cancel();
    _singleMessageSubscription = _messageRepository.streamMessage(id).listen(
      (messageData) {
        _selectedMessage = messageData;
        notifyListeners();
      },
      onError: (Object error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // جلب رسائل الغرفة مع تحديد الحد الأقصى والترتيب الزمني عبر الـ Future
  Future<void> loadMessages(String roomId, {int limit = 100}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _messages = await _messageRepository.getMessages(roomId, limit: limit);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل رسالة محددة عبر المعرف الخاص بها
  Future<void> loadMessage(String id) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedMessage = await _messageRepository.getMessage(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إرسال رسالة جديدة وإرجاع المعرف الخاص بها بعد الإدخال
  Future<String> sendRoomMessage(RoomMessageModel message) async {
    try {
      final String id = await _messageRepository.send(message);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث كائن الرسالة بالكامل ووسمها كرسالة معدلة
  Future<void> updateRoomMessage(RoomMessageModel message) async {
    try {
      await _messageRepository.update(message);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حذف رسالة منطقياً عبر تغيير حالة الحذف وتحديث وقت التعديل
  Future<void> deleteRoomMessage(String id) async {
    try {
      await _messageRepository.delete(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تعديل نص الرسالة مباشرة وتحديث وقت التعديل
  Future<void> editRoomMessage({required String id, required String message}) async {
    try {
      await _messageRepository.edit(id: id, message: message);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ترجمة نص الرسالة وتحديث الحقول المخصصة للغة والترجمة
  Future<void> translateRoomMessage({
    required String id,
    required String language,
    required String message,
  }) async {
    try {
      await _messageRepository.translate(id: id, language: language, message: message);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // استعادة الرسالة المحذوفة منطقياً
  Future<void> restoreRoomMessage(String id) async {
    try {
      await _messageRepository.restore(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // جلب الرسائل الخاصة بمستخدم معين داخل غرفة محددة
  Future<void> loadUserMessages({required String roomId, required String userId}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _userMessages = await _messageRepository.getUserMessages(roomId: roomId, userId: userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب رسائل النظام فقط داخل غرفة معينة
  Future<void> loadSystemMessages(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _systemMessages = await _messageRepository.getSystemMessages(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // حساب عدد الرسائل غير المحذوفة داخل غرفة معينة
  Future<void> refreshMessageCount(String roomId) async {
    try {
      _messageCount = await _messageRepository.count(roomId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // التحقق من وجود رسالة معينة في قاعدة البيانات عبر معرفها
  Future<bool> checkMessageExists(String id) async {
    try {
      return await _messageRepository.exists(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريمات فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _messagesSubscription?.cancel();
    _singleMessageSubscription?.cancel();
    super.dispose();
  }
}
