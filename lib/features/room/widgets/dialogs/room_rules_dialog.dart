import 'package:flutter/material.dart';

class RoomRulesDialog extends StatelessWidget {
  const RoomRulesDialog({
    super.key,
    this.roomName = '',
    this.rules = const [],
  });

  final String roomName;
  final List<String> rules;

  List<String> get _defaultRules => const [
        'احترام جميع أعضاء الغرفة.',
        'يمنع السب أو الإساءة أو التنمر.',
        'يمنع نشر الروابط أو الإعلانات.',
        'يمنع انتحال شخصية الآخرين.',
        'يجب الالتزام بتعليمات المشرفين.',
        'عدم تشغيل موسيقى أو أصوات مزعجة.',
        'يحق للإدارة اتخاذ الإجراءات المناسبة عند المخالفة.',
      ];

  @override
  Widget build(BuildContext context) {
    final items = rules.isEmpty ? _defaultRules : rules;

    return Dialog(
      backgroundColor: const Color(0xff1F2436),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: SizedBox(
        width: 430,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0x22FFC107),
                child: Icon(
                  Icons.gavel_rounded,
                  color: Colors.amber,
                  size: 30,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                roomName.isEmpty
                    ? "قوانين الغرفة"
                    : "قوانين $roomName",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                  itemBuilder: (_, index) {
                    return Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            items[index],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xff4F6BFF),
                    minimumSize:
                        const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("موافق"),
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
    String roomName = '',
    List<String> rules = const [],
  }) {
    return showDialog(
      context: context,
      builder: (_) => RoomRulesDialog(
        roomName: roomName,
        rules: rules,
      ),
    );
  }
}