import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_background_model.dart';
import 'package:joojo_chat/features/room/repositories/room_background_repository.dart';

class RoomBackgroundProvider extends ChangeNotifier {
  RoomBackgroundProvider({required RoomBackgroundRepository roomBackgroundRepository}) 
      : _backgroundRepository = roomBackgroundRepository;

  final RoomBackgroundRepository _backgroundRepository;

  List<RoomBackgroundModel> _backgrounds = [];
  RoomBackgroundModel? _selectedBackground;
  RoomBackgroundModel? _activeBackground; // يمثل الخلفية المستخدمة حالياً في واجهة الغرفة
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomBackgroundModel>>? _backgroundsSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomBackgroundModel> get backgrounds => _backgrounds;
  RoomBackgroundModel? get selectedBackground => _selectedBackground;
  RoomBackgroundModel? get activeBackground => _activeBackground;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // الاستماع البثي الحي والمباشر لكافة الخلفيات التابعة للغرفة (Real-time Stream)
  void listenToRoomBackgrounds(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _backgroundsSubscription?.cancel();
    _backgroundsSubscription = _backgroundRepository.streamBackgrounds(roomId).listen(
      (backgroundsList) {
        _backgrounds = backgroundsList;
        
        // إذا لم يكن هناك خلفية نشطة محددة برمجياً، نعتمد الخلفية الافتراضية المحددة في قاعدة البيانات
        if (_activeBackground == null && backgroundsList.isNotEmpty) {
          final defaultBg = backgroundsList.where((b) => b.isDefault == true);
          _activeBackground = defaultBg.isNotEmpty ? defaultBg.first : backgroundsList.first;
        }
        
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

  // جلب كافة الخلفيات الخاصة بالغرفة بشكل يدوي عبر الـ Future
  Future<void> loadBackgrounds(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _backgrounds = await _backgroundRepository.getBackgrounds(roomId);
      
      if (_activeBackground == null && _backgrounds.isNotEmpty) {
        final defaultBg = _backgrounds.where((b) => b.isDefault == true);
        _activeBackground = defaultBg.isNotEmpty ? defaultBg.first : _backgrounds.first;
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب تفاصيل خلفية معينة بواسطة معرفها
  Future<void> loadBackgroundDetails(String id) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _selectedBackground = await _backgroundRepository.getBackground(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إضافة أو رفع خلفية جديدة للغرفة
  Future<String> uploadBackground(RoomBackgroundModel background) async {
    try {
      final String id = await _backgroundRepository.addBackground(background);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث كائن الخلفية بالكامل بداخل قاعدة البيانات
  Future<void> updateBackgroundInfo(RoomBackgroundModel background) async {
    try {
      await _backgroundRepository.update(background);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حذف خلفية معينة نهائياً
  Future<void> removeBackground(String id) async {
    try {
      await _backgroundRepository.delete(id);
      _backgrounds.removeWhere((b) => b.id == id);
      if (_activeBackground?.id == id) {
        _activeBackground = _backgrounds.isNotEmpty ? _backgrounds.first : null;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // دالة حركية محلية لتغيير ثيم الخلفية الفعلي المعروض للمستخدم في الغرفة حالياً (UI Switch)
  void setRoomThemeBackground(RoomBackgroundModel background) {
    _activeBackground = background;
    notifyListeners();
  }

  @override
  void dispose() {
    _backgroundsSubscription?.cancel();
    super.dispose();
  }
}
