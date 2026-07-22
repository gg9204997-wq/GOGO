import 'package:flutter/material.dart';

import 'package:joojo_chat/core/widgets/app_button.dart';

class AppError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppError({
    required this.message, super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final retry = onRetry;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 70,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            if (retry != null) ...[
              const SizedBox(height: 20),
              AppButton(
                text: 'إعادة المحاولة',
                onPressed: retry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}