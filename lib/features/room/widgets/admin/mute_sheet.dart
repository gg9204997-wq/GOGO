import 'package:flutter/material.dart';

class MuteSheet extends StatefulWidget {
  const MuteSheet({
    super.key,
    required this.userName,
    required this.onMute,
  });

  final String userName;
  final ValueChanged<Duration?> onMute;

  @override
  State<MuteSheet> createState() => _MuteSheetState();
}

class _MuteSheetState extends State<MuteSheet> {
  Duration? _selected;

  final List<(String, Duration?)> _durations = const [
    ('5 دقائق', Duration(minutes: 5)),
    ('10 دقائق', Duration(minutes: 10)),
    ('30 دقيقة', Duration(minutes: 30)),
    ('ساعة', Duration(hours: 1)),
    ('6 ساعات', Duration(hours: 6)),
    ('12 ساعة', Duration(hours: 12)),
    ('24 ساعة', Duration(days: 1)),
    ('دائم', null),
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
                Icons.mic_off,
                color: Colors.redAccent,
                size: 42,
              ),

              const SizedBox(height: 12),

              Text(
                "كتم ${widget.userName}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ..._durations.map((item) {
                return RadioListTile<Duration?>(
                  value: item.$2,
                  groupValue: _selected,
                  activeColor: Colors.redAccent,
                  title: Text(
                    item.$1,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selected = value;
                    });
                  },
                );
              }),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onMute(_selected);
                  },
                  icon: const Icon(Icons.mic_off),
                  label: const Text(
                    "تأكيد الكتم",
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
    required ValueChanged<Duration?> onMute,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return MuteSheet(
          userName: userName,
          onMute: onMute,
        );
      },
    );
  }
}