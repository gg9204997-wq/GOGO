import 'package:flutter/material.dart';

class RoomSettingsDialog extends StatefulWidget {
  const RoomSettingsDialog({
    super.key,
    this.allowGuests = true,
    this.allowChat = true,
    this.allowMic = true,
    this.allowGifts = true,
    this.isLocked = false,
    required this.onSave,
  });

  final bool allowGuests;
  final bool allowChat;
  final bool allowMic;
  final bool allowGifts;
  final bool isLocked;

  final void Function({
    required bool allowGuests,
    required bool allowChat,
    required bool allowMic,
    required bool allowGifts,
    required bool isLocked,
  }) onSave;

  @override
  State<RoomSettingsDialog> createState() =>
      _RoomSettingsDialogState();

  static Future<void> show(
    BuildContext context, {
    bool allowGuests = true,
    bool allowChat = true,
    bool allowMic = true,
    bool allowGifts = true,
    bool isLocked = false,
    required void Function({
      required bool allowGuests,
      required bool allowChat,
      required bool allowMic,
      required bool allowGifts,
      required bool isLocked,
    }) onSave,
  }) {
    return showDialog(
      context: context,
      builder: (_) => RoomSettingsDialog(
        allowGuests: allowGuests,
        allowChat: allowChat,
        allowMic: allowMic,
        allowGifts: allowGifts,
        isLocked: isLocked,
        onSave: onSave,
      ),
    );
  }
}

class _RoomSettingsDialogState
    extends State<RoomSettingsDialog> {
  late bool allowGuests;
  late bool allowChat;
  late bool allowMic;
  late bool allowGifts;
  late bool isLocked;

  @override
  void initState() {
    super.initState();

    allowGuests = widget.allowGuests;
    allowChat = widget.allowChat;
    allowMic = widget.allowMic;
    allowGifts = widget.allowGifts;
    isLocked = widget.isLocked;
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return SwitchListTile(
      value: value,
      activeColor: const Color(0xff4F6BFF),
      secondary: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.white60,
          fontSize: 12,
        ),
      ),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff1F2436),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: SizedBox(
        width: 430,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.settings,
                color: Colors.white,
                size: 40,
              ),

              const SizedBox(height: 12),

              const Text(
                "إعدادات الغرفة",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              _switchTile(
                title: "السماح بالضيوف",
                subtitle: "يمكن للضيوف دخول الغرفة",
                value: allowGuests,
                icon: Icons.group,
                onChanged: (v) =>
                    setState(() => allowGuests = v),
              ),

              _switchTile(
                title: "السماح بالدردشة",
                subtitle: "تشغيل أو إيقاف رسائل الشات",
                value: allowChat,
                icon: Icons.chat,
                onChanged: (v) =>
                    setState(() => allowChat = v),
              ),

              _switchTile(
                title: "السماح بالمايك",
                subtitle: "تشغيل أو إيقاف الميكروفونات",
                value: allowMic,
                icon: Icons.mic,
                onChanged: (v) =>
                    setState(() => allowMic = v),
              ),

              _switchTile(
                title: "السماح بالهدايا",
                subtitle: "تشغيل أو إيقاف إرسال الهدايا",
                value: allowGifts,
                icon: Icons.card_giftcard,
                onChanged: (v) =>
                    setState(() => allowGifts = v),
              ),

              _switchTile(
                title: "قفل الغرفة",
                subtitle: "منع الدخول إلى الغرفة",
                value: isLocked,
                icon: Icons.lock,
                onChanged: (v) =>
                    setState(() => isLocked = v),
              ),

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
                            const Color(0xff4F6BFF),
                      ),
                      onPressed: () {
                        Navigator.pop(context);

                        widget.onSave(
                          allowGuests: allowGuests,
                          allowChat: allowChat,
                          allowMic: allowMic,
                          allowGifts: allowGifts,
                          isLocked: isLocked,
                        );
                      },
                      child: const Text("حفظ"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}