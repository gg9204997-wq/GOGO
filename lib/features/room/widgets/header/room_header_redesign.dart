import 'package:flutter/material.dart';

import '../../models/room_model.dart';

import 'actions/room_actions.dart';
import 'avatar/room_avatar.dart';
import 'background/room_header_background.dart';
import 'background/room_header_border.dart';
import 'background/room_header_glow.dart';
import 'background/room_header_gradient.dart';
import 'background/room_header_light.dart';
import 'background/room_header_particles.dart';
import 'background/room_header_shine.dart';
import 'info/room_country.dart';
import 'info/room_heat.dart';
import 'info/room_progress.dart';
import 'info/room_roomid.dart';
import 'info/room_tags.dart';
import 'info/room_title.dart';
import 'members/member_avatar.dart';
import 'members/room_members.dart';

/// ═══════════════════════════════════════════════════════════════
/// رأس الغرفة الفاخر - تصميم احترافي متقدم
/// ═══════════════════════════════════════════════════════════════

class RoomHeader extends StatelessWidget {
  /// إنشاء رأس الغرفة
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
      height: 180,
      child: Stack(
        children: [
          /// ═══ الخلفيات المتعددة ═══
          const Positioned.fill(child: RoomHeaderBackground()),
          const Positioned.fill(child: RoomHeaderGradient()),
          const Positioned.fill(child: RoomHeaderGlow()),
          const Positioned.fill(child: RoomHeaderLight()),
          const Positioned.fill(child: RoomHeaderParticles()),
          const Positioned.fill(child: RoomHeaderShine()),
          const Positioned.fill(child: RoomHeaderBorder()),

          /// ═══ المحتوى الرئيسي ═══
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Column(
                children: [
                  /// القسم الأول: صورة الغرفة والمعلومات الأساسية والإحصائيات
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// صورة الغرفة مع الإطار الذهبي
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            /// الإطار الذهبي الخارجي
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xffD4AF37),
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xffD4AF37)
                                        .withOpacity(0.4),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: RoomAvatar(
                                imageUrl: room.roomCover,
                                level: room.roomLevel,
                                isOfficial: room.isOfficial,
                                isVerified: room.verified,
                              ),
                            ),

                            /// شارة VIP
                            Positioned(
                              top: -5,
                              left: -5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffB8860B),
                                      Color(0xffFFD700),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: const Text(
                                  'VIP\n8',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff6B1B47),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            /// مستوى الغرفة
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFD700),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  '${room.roomLevel}',
                                  style: const TextStyle(
                                    color: Color(0xff6B1B47),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      /// المعلومات الأساسية والإحصائيات
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// اسم الغرفة والرموز
                            RoomTitle(
                              title: room.roomName,
                              isOfficial: room.isOfficial,
                              isLocked: room.password != null,
                              isLive: true,
                            ),

                            const SizedBox(height: 6),

                            /// رقم الغرفة
                            RoomRoomId(
                              roomId: room.roomNumber.toString(),
                              level: room.roomLevel,
                              country: room.country,
                              language: room.language,
                            ),

                            const SizedBox(height: 8),

                            /// شريط الإحصائيات (الحرارة، الأعضاء، المايك، اللغة)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.08),
                                    Colors.white.withOpacity(0.04),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.12),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /// الحرارة
                                  _StatBadge(
                                    icon: Icons.local_fire_department,
                                    label: '${room.heat}',
                                    color: const Color(0xffFF7043),
                                  ),
                                  const SizedBox(width: 12),

                                  /// الأعضاء النشطين
                                  _StatBadge(
                                    icon: Icons.people_alt,
                                    label: '${room.activeUsers}',
                                    color: const Color(0xff42A5F5),
                                  ),
                                  const SizedBox(width: 12),

                                  /// على المايك
                                  _StatBadge(
                                    icon: Icons.mic,
                                    label: '8/16',
                                    color: const Color(0xff9575CD),
                                  ),
                                  const SizedBox(width: 12),

                                  /// اللغة
                                  _StatBadge(
                                    icon: Icons.language,
                                    label: room.language ?? 'EN',
                                    color: const Color(0xff66BB6A),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),

                            /// الرموز (Featured, Official, Top Room)
                            Row(
                              children: [
                                if (room.isRecommended)
                                  _RoomBadge(
                                    icon: Icons.star,
                                    label: 'Featured',
                                    color: const Color(0xffFFD54F),
                                  ),
                                if (room.isRecommended) const SizedBox(width: 8),
                                if (room.isOfficial)
                                  _RoomBadge(
                                    icon: Icons.verified,
                                    label: 'Official',
                                    color: const Color(0xff42A5F5),
                                  ),
                                if (room.isOfficial) const SizedBox(width: 8),
                                _RoomBadge(
                                  icon: Icons.crown,
                                  label: 'Top Room',
                                  color: const Color(0xffEC407A),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// القسم الثاني: الأزرار الأربعة (Share, Invite, Minimize, Exit)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ActionButtonLarge(
                        icon: Icons.ios_share,
                        label: 'Share',
                        onTap: onShare,
                        color: const Color(0xff9575CD),
                      ),
                      _ActionButtonLarge(
                        icon: Icons.person_add,
                        label: 'Invite',
                        onTap: () {},
                        color: const Color(0xff42A5F5),
                      ),
                      _ActionButtonLarge(
                        icon: Icons.minimize,
                        label: 'Minimize',
                        onTap: onMinimize,
                        color: const Color(0xff9575CD),
                      ),
                      _ActionButtonLarge(
                        icon: Icons.close,
                        label: 'Exit Room',
                        onTap: onExit,
                        color: const Color(0xffFF6B6B),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget للإحصائيات الصغيرة
class _StatBadge extends StatelessWidget {
  const _StatBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// Widget للرموز (Featured, Official, Top Room)
class _RoomBadge extends StatelessWidget {
  const _RoomBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// الأزرار الكبيرة (Share, Invite, Minimize, Exit)
class _ActionButtonLarge extends StatelessWidget {
  const _ActionButtonLarge({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                ],
              ),
              border: Border.all(
                color: color.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
