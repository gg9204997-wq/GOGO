import 'package:flutter/material.dart';

class UserProfileDialog extends StatelessWidget {
  const UserProfileDialog({
    super.key,
    required this.userId,
    required this.userName,
    this.avatar,
    this.level = 1,
    this.country,
    this.bio,
    this.followers = 0,
    this.following = 0,
    this.isModerator = false,
    this.isVip = false,
    this.onFollow,
    this.onMessage,
    this.onGift,
    this.onProfile,
  });

  final String userId;
  final String userName;
  final String? avatar;
  final int level;
  final String? country;
  final String? bio;
  final int followers;
  final int following;
  final bool isModerator;
  final bool isVip;

  final VoidCallback? onFollow;
  final VoidCallback? onMessage;
  final VoidCallback? onGift;
  final VoidCallback? onProfile;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff1F2436),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: const Color(0xff2D3550),
              backgroundImage: avatar != null &&
                      avatar!.isNotEmpty
                  ? NetworkImage(avatar!)
                  : null,
              child: avatar == null ||
                      avatar!.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 42,
                      color: Colors.white,
                    )
                  : null,
            ),

            const SizedBox(height: 14),

            Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "LV.$level",
              style: const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                if (country != null)
                  Chip(
                    label: Text(country!),
                    avatar: const Icon(
                      Icons.flag,
                      size: 18,
                    ),
                  ),
                if (isVip)
                  const Chip(
                    label: Text("VIP"),
                    avatar: Icon(Icons.workspace_premium),
                  ),
                if (isModerator)
                  const Chip(
                    label: Text("مشرف"),
                    avatar: Icon(Icons.admin_panel_settings),
                  ),
              ],
            ),

            if (bio != null && bio!.isNotEmpty) ...[
              const SizedBox(height: 14),
              Text(
                bio!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ],

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                _counter(
                  followers.toString(),
                  "متابع",
                ),
                _counter(
                  following.toString(),
                  "يتابع",
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onFollow?.call();
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text("متابعة"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onMessage?.call();
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text("رسالة"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onGift?.call();
                    },
                    icon: const Icon(Icons.card_giftcard),
                    label: const Text("هدية"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onProfile?.call();
                    },
                    icon: const Icon(Icons.person),
                    label: const Text("الملف"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _counter(String value, String title) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  static Future<void> show(
    BuildContext context, {
    required String userId,
    required String userName,
    String? avatar,
    int level = 1,
    String? country,
    String? bio,
    int followers = 0,
    int following = 0,
    bool isModerator = false,
    bool isVip = false,
    VoidCallback? onFollow,
    VoidCallback? onMessage,
    VoidCallback? onGift,
    VoidCallback? onProfile,
  }) {
    return showDialog(
      context: context,
      builder: (_) => UserProfileDialog(
        userId: userId,
        userName: userName,
        avatar: avatar,
        level: level,
        country: country,
        bio: bio,
        followers: followers,
        following: following,
        isModerator: isModerator,
        isVip: isVip,
        onFollow: onFollow,
        onMessage: onMessage,
        onGift: onGift,
        onProfile: onProfile,
      ),
    );
  }
}