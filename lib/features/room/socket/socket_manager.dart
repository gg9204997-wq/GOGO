import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager extends ChangeNotifier {
  SocketManager({required String serverUrl}) : _serverUrl = serverUrl;

  final String _serverUrl;
  io.Socket? _socket;
  bool _isConnected = false;
  String? _errorMessage;

  // البث الحي لحالة الاتصال بالسيرفر لمراقبتها وعرض مؤشر (متصل/منفصل) بالـ UI
  final StreamController<bool> _connectionStreamController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _connectionStreamController.stream;

  // Getters لحماية المتغيرات من التعديل العشوائي خارج الكلاس
  io.Socket? get socket => _socket;
  bool get isConnected => _isConnected;
  String? get errorMessage => _errorMessage;

  // ==========================================
  // INITIALIZE & CONNECT
  // ==========================================

  // إعداد وتجهيز قناة الاتصال الفورية بسيرفر الـ Node.js / WebSockets
  void initAndConnect() {
    if (_socket != null && _socket!.connected) return;

    try {
      _errorMessage = null;
      notifyListeners();

      // إنشاء السوكيت مع ضبط خيارات الأداء الأسرع وخلفية التوصيل التلقائي
      _socket = io.io(_serverUrl, io.OptionBuilder()
        .setTransports(['websocket']) // استخدام بروتوكول WebSocket النقي حصرياً لتقليل الـ Latency
        .enableAutoConnect() // التوصيل التلقائي عند انقطاع الإنترنت أو السيرفر
        .setReconnectionAttempts(5) // المحاولة 5 مرات قبل رمي خطأ بالشبكة
        .setReconnectionDelay(2000) // الانتظار ثانيتين بين كل محاولة إعادة اتصال
        .build());

      // ربط أحداث الاستماع الأساسية لبنية السوكيت الهيكلية
      _setupBaseListeners();
      
      _socket!.connect();
    } catch (e) {
      _errorMessage = e.toString();
      _isConnected = false;
      _connectionStreamController.add(false);
      notifyListeners();
    }
  }

  // إعداد المستمعين الداخليين لحالة بنية الشبكة المادية
  void _setupBaseListeners() {
    if (_socket == null) return;

    _socket!.onConnect((_) {
      _isConnected = true;
      _errorMessage = null;
      _connectionStreamController.add(true);
      notifyListeners();
    });

    _socket!.onDisconnect((_) {
      _isConnected = false;
      _connectionStreamController.add(false);
      notifyListeners();
    });

    _socket!.onConnectError((Object? error) {
      _errorMessage = error?.toString() ?? 'خطأ غير معروف أثناء التوصيل بالسيرفر';
      _isConnected = false;
      _connectionStreamController.add(false);
      notifyListeners();
    });
  }

  // ==========================================
  // DISCONNECT & CLEANUP
  // ==========================================

  // فصل الاتصال نهائياً بالسيرفر وتنظيف طابور العمليات
  void disconnectServer() {
    if (_socket == null) return;

    _socket!.disconnect();
    _socket!.close();
    _socket = null;
    _isConnected = false;
    _connectionStreamController.add(false);
    notifyListeners();
  }

  @override
  void dispose() {
    // التخلص التام من الـ StreamController لمنع حدوث تسريب في الذاكرة (Memory Leaks)
    _connectionStreamController.close();
    disconnectServer();
    super.dispose();
  }
}
