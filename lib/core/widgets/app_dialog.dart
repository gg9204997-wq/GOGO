import 'package:flutter/material.dart';

import 'package:joojo_chat/core/widgets/app_button.dart';

class AppDialog {
  const AppDialog._();

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            AppButton(
              text: buttonText,
              width: 120,
              height: 45,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}