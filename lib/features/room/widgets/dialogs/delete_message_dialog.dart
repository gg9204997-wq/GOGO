import 'package:flutter/material.dart';
import 'confirm_dialog.dart';

class DeleteMessageDialog {
  const DeleteMessageDialog._();

  static Future<bool?> show(
    BuildContext context, {
    required VoidCallback onConfirm,
    String senderName = '',
    bool forEveryone = true,
  }) {
    return ConfirmDialog.show(
      context,
      title: "حذف الرسالة",
      message: senderName.isEmpty
          ? (forEveryone
              ? "هل تريد حذف هذه الرسالة نهائياً؟"
              : "هل تريد حذف الرسالة من جهازك فقط؟")
          : (forEveryone
              ? "سيتم حذف رسالة $senderName نهائياً من الغرفة."
              : "سيتم حذف رسالة $senderName من جهازك فقط."),
      confirmText: "حذف",
      cancelText: "إلغاء",
      confirmColor: Colors.red,
      icon: Icons.delete_forever_rounded,
      onConfirm: onConfirm,
    );
  }
}