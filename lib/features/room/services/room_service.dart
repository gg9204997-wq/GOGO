// lib/features/room/services/room_service.dart

import 'dart:async';
import 'package:joojo_chat/features/room/models/room_model.dart';
import 'package:joojo_chat/features/room/repositories/room_repository.dart';

class RoomService {
  final RoomRepository _roomRepository;

  RoomService({required RoomRepository roomRepository}) : _roomRepository = roomRepository;

  // ==========================================
  // ⚡ عمليات جلب البيانات الحية (Futures & Streams)
  // ==========================================

  /// جلب الغرف بنظام الصفحات (تمت إضافتها لتطابق استدعاءات الـ Data Layer)
  Future<List<RoomModel>> getRooms({int page = 0, int limit = 20}) async {
    try {
      return await _roomRepository.getRooms(page: page, limit: limit);
    } catch (e) {
      rethrow;
    }
  }

  /// جلب غرف مستخدم معين (المالك)
  Future<List<RoomModel>> getRoomsByOwner(String ownerId) async {
    try {
      return await _roomRepository.getRoomsByOwner(ownerId);
    } catch (e) {
      rethrow;
    }
  }

  /// بث حي لتحديثات غرفة معينة (Real-time Stream)
  Stream<RoomModel?> streamRoom(String roomId) {
    return _roomRepository.streamRoom(roomId);
  }

  /// بث حي لقائمة الغرف بالكامل (Real-time Stream)
  Stream<List<RoomModel>> streamRooms() {
    return _roomRepository.streamRooms();
  }

  /// إغلاق الغرفة منطقياً من السيرفر
  Future<void> closeRoom(String roomId) async {
    try {
      await _roomRepository.closeRoom(roomId);
    } catch (e) {
      rethrow;
    }
  }

  // ==========================================
  // 🔒 التحققات الوقائية والإدارية (Validation)
  // ==========================================

  // فحص أمني محلي للتحقق من مطابقة شروط كلمة المرور قبل قفل الغرفة برقم سري
  bool isRoomPasswordValid(String password) {
    if (password.trim().length < 4) return false;
    final RegExp numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(password);
  }

  // فحص وقائي سريع للتحقق من سلامة روابط الأغلفة والخلفيات الممرة للـ UI
  bool isUrlExtensionValid(String? url) {
    if (url == null || url.trim().isEmpty) return false;
    final lowerUrl = url.toLowerCase();
    return lowerUrl.startsWith('http://') || lowerUrl.startsWith('https://');
  }

  // التحقق وقائياً مما إذا كان المستخدم يمتلك رتبة مالك الغرفة الفعلي للمساعدة في قرارات الـ UI
  bool isUserRoomOwner({required String userId, required RoomModel? room}) {
    if (room == null) return false;
    return room.ownerId == userId;
  }

  // ==========================================
  // 📊 عمليات الفرز والتصفية المحلية (Filtering & Sorting)
  // ==========================================

  // فرز الغرف محلياً بناءً على مستوى شعبية الغرفة (Heat) الأعلى لتسريع العرض التنافسي بالـ UI
  List<RoomModel> sortRoomsByPopularity(List<RoomModel> roomList) {
    final List<RoomModel> sorted = List<RoomModel>.from(roomList);
    sorted.sort((a, b) => b.heat.compareTo(a.heat));
    return sorted;
  }

  // تصفية الغرف برمجياً لاستبعاد الغرف المغلقة منطقياً (Closed Rooms) من العرض في القوائم العامة
  List<RoomModel> filterOpenRoomsOnly(List<RoomModel> roomList) {
    return roomList.where((room) => room.closedAt == null).toList();
  }

  // ==========================================
  // 🎨 تنسيق نصوص الواجهات (UI Formatting)
  // ==========================================

  // صياغة نص منسق لعرض رقم الغرفة أو معرفها الظاهري بشكل جمالي داخل بطاقات الغرف (Room Cards)
  String formatRoomDisplayId(int roomNumber) {
    return 'ID: $roomNumber';
  }

  // تنسيق وعرض أعداد الحضور النشطين داخل بطاقة الغرفة بشكل مقروء ومختصر (مثل: 1.5K أو 250)
  String formatActiveUsersCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}