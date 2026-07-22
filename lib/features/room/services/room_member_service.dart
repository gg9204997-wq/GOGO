import 'package:joojo_chat/features/room/models/room_member_model.dart';

class RoomMemberService {
  // تصفية وفرز قائمة الأعضاء المتواجدين أونلاين لاستخراج من يتحدثون على المايك فقط (Speakers)
  List<RoomMemberModel> filterSpeakers(List<RoomMemberModel> onlineMembers) {
    return onlineMembers.where((member) => member.isSpeaker && member.seatNumber != null).toList();
  }

  // تصفية وفرز قائمة الحضور لاستخراج الجمهور المستمع في الغرفة (Audience) الذين لا يمتلكون مقعداً صوتياً
  List<RoomMemberModel> filterAudience(List<RoomMemberModel> onlineMembers) {
    return onlineMembers.where((member) => !member.isSpeaker || member.seatNumber == null).toList();
  }

  // ترتيب الأعضاء المتواجدين تنازلياً حسب إجمالي الدعم (الماس والعملات) لتغذية لوحة توب الغرفة بالـ UI
  List<RoomMemberModel> sortMembersByContributions(List<RoomMemberModel> membersList) {
    final List<RoomMemberModel> sorted = List<RoomMemberModel>.from(membersList);
    
    sorted.sort((a, b) {
      // حساب القيمة الافتراضية المجمعة (الماس + العملات) بناءً على حقول الموديل الفعلي الخاص بك
      final int totalA = (a.diamondsSent) + (a.coinsSent);
      final int totalB = (b.diamondsSent) + (b.coinsSent);
      return totalB.compareTo(totalA); // الأكبر يظهر في البداية كأعلى داعم
    });

    return sorted;
  }

  // فحص وقائي سريع لمعرفة ما إذا كان العضو يمتلك رتبة كتم صوت سارية المفعول برمجياً قبل التحدث لقنوات Agora
  bool isUserVoiceMuted(RoomMemberModel? member) {
    if (member == null) return false;
    return member.isMuted;
  }
}
