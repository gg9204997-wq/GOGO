import 'package:flutter/material.dart';

class MentionUser {
  final String id;
  final String name;
  final String? avatar;

  const MentionUser({
    required this.id,
    required this.name,
    this.avatar,
  });
}

class MentionWidget extends StatelessWidget {
  const MentionWidget({
    super.key,
    required this.users,
    required this.onSelected,
    this.maxHeight = 260,
  });

  final List<MentionUser> users;
  final ValueChanged<MentionUser> onSelected;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const SizedBox.shrink();
    }

    return Material(
      elevation: 12,
      color: const Color(0xff222738),
      borderRadius: BorderRadius.circular(18),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          itemCount: users.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: Colors.white.withOpacity(.06),
          ),
          itemBuilder: (context, index) {
            final user = users[index];

            return InkWell(
              onTap: () => onSelected(user),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade700,
                      backgroundImage:
                          user.avatar != null &&
                                  user.avatar!.isNotEmpty
                              ? NetworkImage(user.avatar!)
                              : null,
                      child:
                          user.avatar == null ||
                                  user.avatar!.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )
                              : null,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            "@${user.name}",
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.alternate_email,
                      color: Colors.blueAccent,
                      size: 18,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}