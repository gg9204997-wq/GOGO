import 'package:flutter/material.dart';

class BanSheet extends StatefulWidget {
  const BanSheet({
    super.key,
    required this.userName,
    required this.onBan,
  });

  final String userName;
  final ValueChanged<Duration?> onBan;

  @override
  State<BanSheet> createState() => _BanSheetState();
}

class _BanSheetState extends State<BanSheet> {
  Duration? _selected;

  final List<(String, Duration?)> _items = const [
    ('10 دقائق', Duration(minutes: 10)),
    ('30 دقيقة', Duration(minutes: 30)),
    ('ساعة', Duration(hours: 1)),
    ('6 ساعات', Duration(hours: 6)),
    ('12 ساعة', Duration(hours: 12)),
    ('يوم', Duration(days: 1)),
    ('3 أيام', Duration(days: 3)),
    ('7 أيام', Duration(days: 7)),
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
                Icons.block,
                color: Colors.red,
                size: 42,
              ),

              const SizedBox(height: 12),

              Text(
                "حظر ${widget.userName}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ..._items.map((item) {
                final selected = item.$2 == _selected;

                return RadioListTile<Duration?>(
                  value: item.$2,
                  groupValue: _selected,
                  activeColor: Colors.red,
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
                    backgroundColor: Colors.red,
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onBan(_selected);
                  },
                  icon: const Icon(Icons.block),
                  label: const Text("تأكيد الحظر"),
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
    required ValueChanged<Duration?> onBan,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return BanSheet(
          userName: userName,
          onBan: onBan,
        );
      },
    );
  }
}