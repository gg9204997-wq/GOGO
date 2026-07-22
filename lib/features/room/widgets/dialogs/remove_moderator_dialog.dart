import 'package:flutter/material.dart';
import 'confirm_dialog.dart';

class RemoveModeratorDialog {
  const RemoveModeratorDialog._();

  static Future<bool?> show(
    BuildContext context, {
    required String moderatorName,
    required VoidCallback onConfirm,
  }) {
    return ConfirmDialog.show(
      context,
      title: "إزالة مشرف",
      message:
          "هل أنت متأكد من إزالة صلاحيات الإشراف من $moderatorName؟\n\nسيعود المستخدم إلى عضو عادي داخل الغرفة.",
      confirmText: "إزالة",
      cancelText: "إلغاء",
      confirmColor: Colors.red,
      icon: Icons.admin_panel_settings_outlined,
      onConfirm: onConfirm,
    );
  }
}