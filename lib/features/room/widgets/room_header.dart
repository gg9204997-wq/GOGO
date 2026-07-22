import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:joojo_chat/features/room/models/room_model.dart';
import 'package:joojo_chat/features/room/providers/room_provider.dart';

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

/// ═══════════════════════════════════════════════════════════════
/// رأس الغرفة الصوتية - يعرض جميع معلومات الغرفة والأعضاء والإحصائيات
/// ═══════════════════════════════════════════════════════════════

class RoomHeader extends StatelessWidget {
  /// إنشاء رأس الغرفة
  /// 
  /// [room] - بيانات الغرفة الكاملة
  /// [members] - قائمة صور الأعضاء المراد عرضها
  /// [onShare] - callback عند الضغط على زر المشاركة
  /// [onMinimize] - callback عند الضغط على زر التصغير
  /// [onExit] - callback عند الضغط على زر الخروج
  const RoomHeader({
    super.key,
    required this.room,
    required this.members,
    required this.onShare,
    required this.onMinimize,
    required this.onExit,
  });

  /// بيانات الغرفة الكاملة
  final RoomModel room;

  /// قائمة بيانات صور الأعضاء المعروضة
  final List<MemberAvatarData> members;

  /// callback عند الضغط على المشاركة
  final VoidCallback onShare;

  /// callback عند الضغط على التصغير
  final VoidCallback onMinimize;

  /// callback عند الضغط على الخروج
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    // الحصول على بيانات الغرفة من الـ Provider
    final currentRoom = context.watch<RoomProvider>().currentRoom ?? room;

    return SizedBox(
      height: 130,
      child: Stack(
        children: [
          /// ═══ الخلفيات المتعددة - طبقات بصرية متقدمة ═══
          
          /// الخلفية الأساسية
          const Positioned.fill(
            child: RoomHeaderBackground(),
          ),

          /// التدرج اللوني (Gradient)
          const Positioned.fill(
            child: RoomHeaderGradient(),
          ),

          /// التوهج (Glow Effect)
          const Positioned.fill(
            child: RoomHeaderGlow(),
          ),

          /// الإضاءة الناعمة (Light Effect)
          const Positioned.fill(
            child: RoomHeaderLight(),
          ),

          /// جزيئات التأثير (Particles)
          const Positioned.fill(
            child: RoomHeaderParticles(),
          ),

          /// تأثير اللمعان (Shine Effect)
          const Positioned.fill(
            child: RoomHeaderShine(),
          ),

          /// الحدود الزخرفية (Border)
          const Positioned.fill(
            child: RoomHeaderBorder(),
          ),

          /// ═══ المحتوى الرئيسي ═══
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ═══ صورة الغرفة مع الرموز ═══
                  RoomAvatar(
                    imageUrl: currentRoom.roomCover,
                    level: currentRoom.roomLevel,
                    isOfficial: currentRoom.isOfficial,
                    isVerified: currentRoom.verified,
                  ),

                  const SizedBox(width: 12),

                  /// ═══ معلومات الغرفة والإحصائيات ═══
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// اسم الغرفة مع الرموز
                        RoomTitle(
                          title: currentRoom.roomName,
                          isOfficial: currentRoom.isOfficial,
                          isLocked: currentRoom.password != null,
                          isLive: true,
                        ),

                        const SizedBox(height: 5),

                        /// رقم الغرفة والمستوى والدولة واللغة
                        RoomRoomId(
                          roomId: currentRoom.roomNumber.toString(),
                          level: currentRoom.roomLevel,
                          country: currentRoom.country,
                          language: currentRoom.language,
                        ),

                        const SizedBox(height: 6),

                        /// اسم الدولة والعلم
                        RoomCountry(
                          countryName: currentRoom.country,
                          flag: '🌍', // يمكن إضافة العلم من البيانات
                        ),

                        const SizedBox(height: 6),

                        /// الوسوم (Tags)
                        if (currentRoom.tags.isNotEmpty)
                          RoomTags(
                            tags: currentRoom.tags,
                          ),

                        const SizedBox(height: 6),

                        /// درجة الحرارة والأعضاء النشطين والألماس والهدايا
                        RoomHeat(
                          heat: currentRoom.heat,
                          online: currentRoom.activeUsers,
                          diamonds: 0, // سيتم استبداله ببيانات فعلية
                          gifts: currentRoom.totalGifts,
                        ),

                        const SizedBox(height: 6),

                        /// شريط التقدم لمستوى الغرفة
                        RoomProgress(
                          currentXp: 0, // سيتم استبداله ببيانات فعلية
                          nextLevelXp: 100, // سيتم استبداله ببيانات فعلية
                          level: currentRoom.roomLevel,
                        ),

                        const SizedBox(height: 6),

                        /// الإحصائيات (الإعجابات والمتابعين والزيارات)
                        RoomStatistics(
                          likes: 0, // سيتم استبداله ببيانات فعلية
                          followers: 0, // سيتم استبداله ببيانات فعلية
                          visits: currentRoom.totalVisitors,
                          duration: '0:00', // سيتم استبداله ببيانات فعلية
                        ),

                        const Spacer(),

                        /// صور الأعضاء النشطين
                        RoomMembers(
                          members: members,
                          totalMembers: currentRoom.activeUsers,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// ═══ أزرار الإجراءات (المشاركة، التصغير، الخروج) ═══
                  RoomActions(
                    onShare: onShare,
                    onMinimize: onMinimize,
                    onExit: onExit,
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
