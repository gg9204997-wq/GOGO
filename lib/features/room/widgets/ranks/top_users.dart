import 'package:flutter/material.dart';

class TopUsers extends StatelessWidget {
  final List<TopUser> users;
  final VoidCallback? onSeeAll;

  const TopUsers({
    super.key,
    this.users = const [],
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final list = users.isEmpty ? _demoUsers : users;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1D2233),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.leaderboard_rounded,
                color: Colors.amber,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "أفضل المستخدمين",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                child: const Text("عرض الكل"),
              ),
            ],
          ),

          const SizedBox(height: 15),

          ...List.generate(
            list.length,
            (index) => _UserTile(
              rank: index + 1,
              user: list[index],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final int rank;
  final TopUser user;

  const _UserTile({
    required this.rank,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _rankColor(rank),
              shape: BoxShape.circle,
            ),
            child: Text(
              "$rank",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 10),

          CircleAvatar(
            radius: 24,
            backgroundImage: user.avatar != null
                ? NetworkImage(user.avatar!)
                : null,
            child: user.avatar == null
                ? const Icon(Icons.person)
                : null,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (user.vip)
                      const Icon(
                        Icons.workspace_premium,
                        color: Colors.amber,
                        size: 18,
                      ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  "Lv.${user.level}",
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 6),

                LinearProgressIndicator(
                  value: user.points / 100,
                  minHeight: 6,
                  borderRadius:
                      BorderRadius.circular(20),
                  backgroundColor: Colors.white12,
                  valueColor:
                      AlwaysStoppedAnimation(
                    _rankColor(rank),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
                size: 18,
              ),
              const SizedBox(height: 4),
              Text(
                "${user.points.toInt()}",
                style: TextStyle(
                  color: _rankColor(rank),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _rankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.deepOrange;
      default:
        return Colors.blueAccent;
    }
  }
}

class TopUser {
  final String name;
  final String? avatar;
  final int level;
  final double points;
  final bool vip;

  const TopUser({
    required this.name,
    required this.level,
    required this.points,
    this.avatar,
    this.vip = false,
  });
}

const List<TopUser> _demoUsers = [
  TopUser(
    name: "JoJo",
    level: 120,
    points: 98,
    vip: true,
  ),
  TopUser(
    name: "محمد",
    level: 95,
    points: 92,
  ),
  TopUser(
    name: "أحمد",
    level: 88,
    points: 85,
  ),
  TopUser(
    name: "سارة",
    level: 72,
    points: 79,
    vip: true,
  ),
];