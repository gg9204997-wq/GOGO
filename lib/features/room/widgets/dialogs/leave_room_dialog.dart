import 'package:flutter/material.dart';
import 'confirm_dialog.dart';

class LeaveRoomDialog {
  const LeaveRoomDialog._();

  static Future<bool?> show(
    BuildContext context, {
    required VoidCallback onConfirm,
    String roomName = '',
    bool isOwner = false,
  }) {
    return ConfirmDialog.show(
      context,
      title: isOwner ? "إغلاق الغرفة" : "مغادرة الغرفة",
      message: isOwner
          ? (roomName.isEmpty
              ? "أنت مالك الغرفة. عند المغادرة سيتم إغلاق الغرفة وإنهاء الجلسة."
              : "أنت مالك غرفة \"$roomName\". عند المغادرة سيتم إغلاق الغرفة وإنهاء الجلسة.")
          : (roomName.isEmpty
              ? "هل تريد مغادرة الغرفة؟"
              : "هل تريد مغادرة غرفة \"$roomName\"؟"),
      confirmText: isOwner ? "إغلاق الغرفة" : "مغادرة",
      cancelText: "إلغاء",
      confirmColor: isOwner ? Colors.red : Colors.orange,
      icon: isOwner ? Icons.meeting_room : Icons.logout_rounded,
      onConfirm: onConfirm,
    );
  }
}