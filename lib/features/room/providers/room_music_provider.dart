import 'dart:async';
import 'package:flutter/material.dart';
import 'package:joojo_chat/features/room/models/room_music_model.dart';
import 'package:joojo_chat/features/room/repositories/room_music_repository.dart';

class RoomMusicProvider extends ChangeNotifier {
  RoomMusicProvider({required RoomMusicRepository roomMusicRepository}) 
      : _roomMusicRepository = roomMusicRepository;

  final RoomMusicRepository _roomMusicRepository;

  List<RoomMusicModel> _playlist = [];
  RoomMusicModel? _currentPlaying;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<List<RoomMusicModel>>? _musicSubscription;

  // Getters لحماية البيانات من التعديل العشوائي خارج الـ Provider
  List<RoomMusicModel> get playlist => _playlist;
  RoomMusicModel? get currentPlaying => _currentPlaying;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // البث الحي لمزامنة تشغيل الموسيقى والوقت الحالي لحظياً مع جميع الأعضاء (Real-time Stream)
  void listenToPlaylist(String roomId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _musicSubscription?.cancel();
    _musicSubscription = _roomMusicRepository.streamPlaylist(roomId).listen(
      (musicList) {
        _playlist = musicList;
        
        // استخراج الأغنية التي تعمل حالياً تلقائياً من الستريم
        final playing = musicList.where((m) => m.isPlaying == true);
        _currentPlaying = playing.isNotEmpty ? playing.first : null;
        
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

  // جلب قائمة الأغاني المضافة داخل غرفة معينة بشكل يدوي عبر الـ Future
  Future<void> loadPlaylist(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _playlist = await _roomMusicRepository.getPlaylist(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // جلب الموسيقى التي تعمل حالياً داخل الغرفة يدويًا
  Future<void> loadCurrentPlaying(String roomId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _currentPlaying = await _roomMusicRepository.getCurrentPlaying(roomId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // إضافة أغنية جديدة إلى قائمة التشغيل (Playlist) الخاصة بالغرفة
  Future<String> addTrack(RoomMusicModel music) async {
    try {
      final String id = await _roomMusicRepository.addMusic(music);
      return id;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // تحديث حالة التشغيل والموضع الحالي للموسيقى (مزامنة الوقت بين المستخدمين)
  Future<void> changePlayback({
    required String id,
    required bool isPlaying,
    required int position,
  }) async {
    try {
      await _roomMusicRepository.updatePlayback(id: id, isPlaying: isPlaying, position: position);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تحديث كائن الموسيقى بالكامل
  Future<void> updateTrackInfo(RoomMusicModel music) async {
    try {
      await _roomMusicRepository.update(music);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // إيقاف الأغنية الحالية (Pause)
  Future<void> pauseTrack(String id) async {
    try {
      await _roomMusicRepository.pauseMusic(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // حذف أغنية من قائمة التشغيل نهائياً
  Future<void> removeTrack(String id) async {
    try {
      await _roomMusicRepository.removeMusic(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // تصفير أو حذف قائمة التشغيل بالكامل للغرفة
  Future<void> clearAllTracks(String roomId) async {
    try {
      await _roomMusicRepository.clearPlaylist(roomId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // إلغاء بث الستريم فوراً عند الخروج لتجنب الـ Memory Leaks وحماية الذاكرة
    _musicSubscription?.cancel();
    super.dispose();
  }
}
