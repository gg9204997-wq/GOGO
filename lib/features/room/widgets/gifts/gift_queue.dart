import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

/// عنصر داخل طابور عرض الهدايا
class GiftQueueItem {
  const GiftQueueItem({
    required this.id,
    required this.widget,
    this.duration = const Duration(seconds: 3),
  });

  final String id;
  final Widget widget;
  final Duration duration;
}

/// مدير طابور الهدايا
class GiftQueue extends ChangeNotifier {
  final Queue<GiftQueueItem> _queue = Queue<GiftQueueItem>();

  GiftQueueItem? _currentGift;

  Timer? _timer;

  bool _isPlaying = false;

  /// الهدية الحالية
  GiftQueueItem? get currentGift => _currentGift;

  /// هل يوجد تأثير يعمل الآن
  bool get isPlaying => _isPlaying;

  /// عدد الهدايا المنتظرة
  int get pendingCount => _queue.length;

  /// هل الطابور فارغ
  bool get isEmpty =>
      !_isPlaying &&
      _queue.isEmpty &&
      _currentGift == null;

  /// إضافة هدية
  void add(
    GiftQueueItem item,
  ) {
    _queue.add(item);

    if (!_isPlaying) {
      _playNext();
    }

    notifyListeners();
  }

  /// إضافة مجموعة هدايا
  void addAll(
    Iterable<GiftQueueItem> items,
  ) {
    _queue.addAll(items);

    if (!_isPlaying) {
      _playNext();
    }

    notifyListeners();
  }

  /// إزالة أول عنصر منتظر
  GiftQueueItem? removeFirst() {
    if (_queue.isEmpty) return null;

    final item = _queue.removeFirst();

    notifyListeners();

    return item;
  }

  /// إنهاء الهدية الحالية يدوياً
  void finishCurrent() {
    _timer?.cancel();
    _playNext();
  }

  /// إيقاف الطابور
  void stop() {
    _timer?.cancel();
    _currentGift = null;
    _isPlaying = false;
    notifyListeners();
  }

  /// مسح الطابور بالكامل
  void clear() {
    _timer?.cancel();

    _queue.clear();

    _currentGift = null;

    _isPlaying = false;

    notifyListeners();
  }

  void _playNext() {
    _timer?.cancel();

    if (_queue.isEmpty) {
      _currentGift = null;
      _isPlaying = false;
      notifyListeners();
      return;
    }

    _currentGift = _queue.removeFirst();

    _isPlaying = true;

    notifyListeners();

    _timer = Timer(
      _currentGift!.duration,
      () {
        _playNext();
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}