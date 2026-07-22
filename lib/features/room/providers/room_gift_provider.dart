import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/gift_model.dart';
import 'package:joojo_chat/features/room/repositories/gift_repository.dart';

class RoomGiftProvider extends ChangeNotifier {
  RoomGiftProvider({required GiftRepository giftRepository}) : _giftRepository = giftRepository;

  final GiftRepository _giftRepository;

  List<GiftModel> _availableGifts = [];
  List<GiftModel> _activeRoomGifts = [];
  GiftModel? _lastReceivedGift;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<GiftModel>>? _giftsSubscription;

  // Getters
  List<GiftModel> get availableGifts => _availableGifts;
  List<GiftModel> get activeRoomGifts => _activeRoomGifts;
  GiftModel? get lastReceivedGift => _lastReceivedGift;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // الاستماع المباشر والحي للهدايا المرسلة داخل الغرفة الحالية لتشغيل الـ SVGA والـ Combo
  void listenToRoomGifts(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _giftsSubscription?.cancel();
    _giftsSubscription = _giftRepository.streamRoomGifts(roomId).listen(
      (giftsList) {
        _activeRoomGifts = giftsList;
        if (giftsList.isNotEmpty) {
          _lastReceivedGift = giftsList.last;
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

  // جلب الهدايا المتاحة في البانل للمستخدم
  Future<void> loadAvailableGifts() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _availableGifts = await _giftRepository.getAvailableGifts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إرسال هدية جديدة عبر الـ Repository
  Future<bool> sendGiftToUser(GiftModel gift) async {
    try {
      final success = await _giftRepository.sendGift(gift);
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // دالة تُستدعى يدوياً في حالة الرغبة بضخ أنميشن قادم من السوكيت مباشرة
  void triggerGiftAnimation(GiftModel gift) {
    _lastReceivedGift = gift;
    notifyListeners();
  }

  @override
  void dispose() {
    _giftsSubscription?.cancel();
    super.dispose();
  }
}
