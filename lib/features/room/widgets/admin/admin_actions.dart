import 'package:flutter/material.dart';

enum AdminAction {
  mute,
  unMute,
  kick,
  ban,
  unBan,
  lockMic,
  unlockMic,
  moveSeat,
  removeSeat,
  pinMessage,
  deleteMessage,
  makeModerator,
  removeModerator,
  openProfile,
}

extension AdminActionExtension on AdminAction {
  String get title {
    switch (this) {
      case AdminAction.mute:
        return "كتم الميكروفون";

      case AdminAction.unMute:
        return "إلغاء الكتم";

      case AdminAction.kick:
        return "طرد من الغرفة";

      case AdminAction.ban:
        return "حظر";

      case AdminAction.unBan:
        return "إلغاء الحظر";

      case AdminAction.lockMic:
        return "قفل الميك";

      case AdminAction.unlockMic:
        return "فتح الميك";

      case AdminAction.moveSeat:
        return "نقل للمقعد";

      case AdminAction.removeSeat:
        return "إنزال من المقعد";

      case AdminAction.pinMessage:
        return "تثبيت الرسالة";

      case AdminAction.deleteMessage:
        return "حذف الرسالة";

      case AdminAction.makeModerator:
        return "تعيين مشرف";

      case AdminAction.removeModerator:
        return "إزالة الإشراف";

      case AdminAction.openProfile:
        return "الملف الشخصي";
    }
  }

  IconData get icon {
    switch (this) {
      case AdminAction.mute:
        return Icons.mic_off;

      case AdminAction.unMute:
        return Icons.mic;

      case AdminAction.kick:
        return Icons.logout;

      case AdminAction.ban:
        return Icons.block;

      case AdminAction.unBan:
        return Icons.check_circle;

      case AdminAction.lockMic:
        return Icons.lock;

      case AdminAction.unlockMic:
        return Icons.lock_open;

      case AdminAction.moveSeat:
        return Icons.swap_horiz;

      case AdminAction.removeSeat:
        return Icons.event_seat;

      case AdminAction.pinMessage:
        return Icons.push_pin;

      case AdminAction.deleteMessage:
        return Icons.delete;

      case AdminAction.makeModerator:
        return Icons.admin_panel_settings;

      case AdminAction.removeModerator:
        return Icons.person_remove;

      case AdminAction.openProfile:
        return Icons.person;
    }
  }

  Color get color {
    switch (this) {
      case AdminAction.kick:
      case AdminAction.ban:
      case AdminAction.deleteMessage:
      case AdminAction.removeModerator:
        return Colors.red;

      case AdminAction.makeModerator:
        return Colors.amber;

      default:
        return Colors.white;
    }
  }
}