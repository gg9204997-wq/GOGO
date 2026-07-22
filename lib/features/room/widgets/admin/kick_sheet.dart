import 'package:flutter/material.dart';

class KickSheet extends StatefulWidget {
  const KickSheet({
    super.key,
    required this.userName,
    required this.onKick,
  });

  final String userName;
  final ValueChanged<String?> onKick;

  @override
  State<KickSheet> createState() => _KickSheetState();
}

class _KickSheetState extends State<KickSheet> {
  String? _reason;

  final List<String> _reasons = const [
    'إزعاج المستخدمين',
    'ألفاظ غير لائقة',
    'سبام',
    'مخالفة قوانين الغرفة',
    'استخدام مايك غير مناسب',
    'سبب آخر',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        color: const Color(0xff1F2436),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 20),

              const Icon(
                Icons.logout_rounded,
                color: Colors.orange,
                size: 42,
              ),

              const SizedBox(height: 12),

              Text(
                "طرد ${widget.userName}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 20),

              ..._reasons.map(
                (reason) => RadioListTile<String>(
                  value: reason,
                  groupValue: _reason,
                  activeColor: Colors.orange,
                  title: Text(
                    reason,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _reason = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onKick(_reason);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    "تأكيد الطرد",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required String userName,
    required ValueChanged<String?> onKick,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return KickSheet(
          userName: userName,
          onKick: onKick,
        );
      },
    );
  }
}