import 'package:joojo_chat/features/room/models/room_request_model.dart';

class RoomRequestService {
  // فحص ما إذا كان الطلب لا يزال معلقاً وقابلاً للمعالجة من قِبل المشرفين (Pending State)
  bool isRequestActionable(RoomRequestModel request) {
    return request.status == 'pending';
  }

  // تصفية طابور الطلبات وفصلها بناءً على نوع الطلب (مثل طلبات الصعود كمسؤول مقابل طلبات المايك العامة)
  List<RoomRequestModel> filterRequestsByType({
    required List<RoomRequestModel> requests,
    required String targetType,
  }) {
    return requests.where((request) => request.requestType == targetType).toList();
  }

  // حساب كم عدد طلبات الانتظار التي تسبق مستخدماً معيناً في الطابور لإظهاره بالـ UI (Queue Position)
  int calculateQueuePosition({
    required List<RoomRequestModel> pendingQueue,
    required String userId,
  }) {
    // الطابور مرتب بالأقدم أولاً، لذا نبحث عن ترتيب العضو داخل المصفوفة
    final int index = pendingQueue.indexWhere((request) => request.userId == userId);
    
    // إذا لم يتم العثور عليه يرجع -1، وإذا وُجد نضيف 1 لأن الـ index يبدأ من الصفر
    return index != -1 ? index + 1 : -1;
  }

  // تحويل نوع الطلب البرمجي الممرر لاسم عربي مقروء ومفهوم داخل لوحات إدارة المشرفين بالـ UI
  String getRequestTypeDisplayName(String requestType) {
    switch (requestType) {
      case 'speaker_join':
        return 'طلب صعود المنصة الصوتية';
      case 'moderator_apply':
        return 'طلب رتبة إشراف مؤقتة';
      case 'co_host':
        return 'طلب استضافة مشتركة';
      default:
        return 'طلب عام داخل الغرفة';
    }
  }
}
