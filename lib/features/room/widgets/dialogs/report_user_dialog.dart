import 'package:flutter/material.dart';

class ReportUserDialog extends StatefulWidget {
  const ReportUserDialog({
    super.key,
    required this.userName,
    required this.onSubmit,
  });

  final String userName;
  final ValueChanged<String> onSubmit;

  @override
  State<ReportUserDialog> createState() =>
      _ReportUserDialogState();
}

class _ReportUserDialogState
    extends State<ReportUserDialog> {
  final TextEditingController _controller =
      TextEditingController();

  String _selectedReason = "إساءة";

  final List<String> _reasons = const [
    "إساءة",
    "ألفاظ غير لائقة",
    "تحرش",
    "سبام",
    "انتحال شخصية",
    "محتوى مخالف",
    "سبب آخر",
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    String text = _selectedReason;

    if (_selectedReason == "سبب آخر" &&
        _controller.text.trim().isNotEmpty) {
      text = _controller.text.trim();
    }

    Navigator.pop(context);

    widget.onSubmit(text);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff1F2436),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.flag,
              color: Colors.orange,
              size: 42,
            ),

            const SizedBox(height: 12),

            Text(
              "الإبلاغ عن ${widget.userName}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _selectedReason,
              dropdownColor: const Color(0xff2A3148),
              decoration: const InputDecoration(
                labelText: "سبب البلاغ",
              ),
              items: _reasons
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedReason = value!;
                });
              },
            ),

            if (_selectedReason == "سبب آخر") ...[
              const SizedBox(height: 16),

              TextField(
                controller: _controller,
                maxLines: 4,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "اكتب سبب البلاغ...",
                  filled: true,
                  fillColor: const Color(0xff2A3148),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    child: const Text("إلغاء"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orange,
                    ),
                    onPressed: _submit,
                    child: const Text("إرسال"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required String userName,
    required ValueChanged<String> onSubmit,
  }) {
    return showDialog(
      context: context,
      builder: (_) => ReportUserDialog(
        userName: userName,
        onSubmit: onSubmit,
      ),
    );
  }
}