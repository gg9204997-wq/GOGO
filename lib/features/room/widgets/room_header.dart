import 'header/actions/room_actions.dart';

import 'header/avatar/room_avatar.dart';

import 'header/background/room_header_background.dart';
import 'header/background/room_header_border.dart';
import 'header/background/room_header_glow.dart';
import 'header/background/room_header_gradient.dart';
import 'header/background/room_header_light.dart';
import 'header/background/room_header_particles.dart';
import 'header/background/room_header_shine.dart';

import 'header/info/room_country.dart';
import 'header/info/room_heat.dart';
import 'header/info/room_progress.dart';
import 'header/info/room_roomid.dart';
import 'header/info/room_statistics.dart';
import 'header/info/room_tags.dart';
import 'header/info/room_title.dart';

import 'header/members/member_avatar.dart';
import 'header/members/room_members.dart';

class RoomHeader extends StatelessWidget {
  const RoomHeader({
    super.key,
    required this.room,
    required this.members,
    required this.onShare,
    required this.onMinimize,
    required this.onExit,
  });

  final RoomModel room;
  final List<MemberAvatarData> members;

  final VoidCallback onShare;
  final VoidCallback onMinimize;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(
        children: [
          const Positioned.fill(
            child: RoomHeaderBackground(),
          ),

          const Positioned.fill(
            child: RoomHeaderGradient(),
          ),

          const Positioned.fill(
            child: RoomHeaderGlow(),
          ),

          const Positioned.fill(
            child: RoomHeaderLight(),
          ),

          const Positioned.fill(
            child: RoomHeaderParticles(),
          ),

          const Positioned.fill(
            child: RoomHeaderShine(),
          ),

          const Positioned.fill(
            child: RoomHeaderBorder(),
          ),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                8,
                12,
                8,
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  /// Avatar
                  RoomAvatar(
                    imageUrl: room.roomCover,
                    level: room.roomLevel,
                    isOfficial: room.isOfficial,
                    isVerified: room.verified,
                  ),

                  const SizedBox(width: 12),

                  /// معلومات الغرفة
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        RoomTitle(
                          title: room.roomName,
                          isOfficial: room.isOfficial,
                          isLocked: room.password != null,
                          isLive: true,
                        ),

                        const SizedBox(height: 5),

                        RoomRoomId(
                          roomId:
                              room.roomNumber.toString(),
                          level: room.roomLevel,
                          country: room.country,
                          language: room.language,
                        ),

                        const SizedBox(height: 6),

                        RoomCountry(
                          countryName: room.country,
                          flag: room.countryFlag,
                        ),                        const SizedBox(height: 6),

                        RoomTags(
                          tags: room.tags,
                        ),

                        const SizedBox(height: 6),

                        RoomHeat(
                          heat: room.heat.toInt(),
                          online: room.activeUsers,
                          diamonds: room.totalDiamonds,
                          gifts: room.totalGifts.toInt(),
                        ),

                        const SizedBox(height: 6),

                        RoomProgress(
                          currentXp: room.currentXp,
                          nextLevelXp: room.nextLevelXp,
                          level: room.roomLevel,
                        ),

                        const SizedBox(height: 6),

                        RoomStatistics(
                          likes: room.likes,
                          followers: room.followers,
                          visits: room.visits,
                          duration: room.liveDuration,
                        ),

                        const Spacer(),

                        RoomMembers(
                          members: members,
                          totalMembers: room.activeUsers,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  RoomActions(
                    onShare: onShare,
                    onMinimize: onMinimize,
                    onExit: onExit,
                  ),                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}