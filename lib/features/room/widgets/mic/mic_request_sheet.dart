import 'package:flutter/material.dart';

class MicRequestSheet extends StatelessWidget {
  const MicRequestSheet({
    super.key,
    required this.onAccept,
    required this.onReject,
    this.username = '',
    this.avatarUrl = '',
    this.message,
  });

  final VoidCallback onAccept;
  final VoidCallback onReject;

  final String username;
  final String avatarUrl;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xff171717),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 24),

            CircleAvatar(
              radius: 34,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: avatarUrl.isNotEmpty
                  ? NetworkImage(avatarUrl)
                  : null,
              child: avatarUrl.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 36,
                      color: Colors.white,
                    )
                  : null,
            ),

            const SizedBox(height: 16),

            Text(
              username.isEmpty ? "طلب مايك" : username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              message ??
                  "يريد الانضمام إلى المايك.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onReject();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("رفض"),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onAccept();
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("قبول"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}