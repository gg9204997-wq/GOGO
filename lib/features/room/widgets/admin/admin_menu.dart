import 'package:flutter/material.dart';
import 'admin_actions.dart';

class AdminMenu extends StatelessWidget {
  const AdminMenu({
    super.key,
    required this.actions,
    required this.onSelected,
    this.title = "أدوات الإدارة",
  });

  final List<AdminAction> actions;
  final ValueChanged<AdminAction> onSelected;
  final String title;

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
          padding: const EdgeInsets.only(
            top: 18,
            bottom: 24,
          ),
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

              const SizedBox(height: 18),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: actions.length,
                  separatorBuilder: (_, __) =>
                      Divider(
                    color: Colors.white.withOpacity(.06),
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    final action = actions[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            action.color.withOpacity(.15),
                        child: Icon(
                          action.icon,
                          color: action.color,
                        ),
                      ),
                      title: Text(
                        action.title,
                        style: TextStyle(
                          color: action.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.white38,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        onSelected(action);
                      },
                    );
                  },
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
    required List<AdminAction> actions,
    required ValueChanged<AdminAction> onSelected,
    String title = "أدوات الإدارة",
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return AdminMenu(
          actions: actions,
          onSelected: onSelected,
          title: title,
        );
      },
    );
  }
}