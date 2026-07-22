import 'package:flutter/material.dart';

import 'member_ring.dart';
import 'online_indicator.dart';

class MemberAvatarData {
  const MemberAvatarData({
    required this.imageUrl,
    this.isOnline = true,
    this.isVip = false,
    this.isHost = false,
  });

  final String? imageUrl;
  final bool isOnline;
  final bool isVip;
  final bool isHost;
}

class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    super.key,
    required this.data,
  });

  final MemberAvatarData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          MemberRing(
            size: 32,
            isVip: data.isVip,
            isHost: data.isHost,
            child: data.imageUrl != null &&
                    data.imageUrl!.isNotEmpty
                ? Image.network(
                    data.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _placeholder(),
                  )
                : _placeholder(),
          ),

          Positioned(
            right: -1,
            bottom: -1,
            child: OnlineIndicator(
              size: 10,
              isOnline: data.isOnline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xff2E3446),
      alignment: Alignment.center,
      child: const Icon(
        Icons.person,
        size: 16,
        color: Colors.white70,
      ),
    );
  }
}