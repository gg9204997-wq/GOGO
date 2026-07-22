import 'package:flutter/material.dart';

import '../models/room_model.dart';

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
/// رأس الغرفة - يعرض جميع معلومات الغرفة والإحصائيات والأعضاء
/// ═══════════════════════════════════════════════════════════════

class RoomHeader extends StatelessWidget {
  /// إنشاء رأس الغرفة
  /// 
  /// [room] - بيانات الغرفة الكاملة (RoomModel)
  /// [members] - قائمة صور الأعضاء المعروضة
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

  /// بيانات الغرفة الكاملة من RoomModel
  final RoomModel room;

  /// قائمة بيانات صور الأعضاء المعروضة في الرأس
  final List<MemberAvatarData> members;

  /// دالة المشاركة
  final VoidCallback onShare;

  /// دالة التصغير
  final VoidCallback onMinimize;

  /// دالة الخروج
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
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
                    imageUrl: room.roomCover,
                    level: room.roomLevel,
                    isOfficial: room.isOfficial,
                    isVerified: room.verified,
                  ),

                  const SizedBox(width: 12),

                  /// ═══ معلومات الغرفة والإحصائيات ═══
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// اسم الغرفة مع الرموز
                        RoomTitle(
                          title: room.roomName,
                          isOfficial: room.isOfficial,
                          isLocked: room.password != null,
                          isLive: true,
                        ),

                        const SizedBox(height: 5),

                        /// رقم الغرفة والمستوى والدولة واللغة
                        RoomRoomId(
                          roomId: room.roomNumber.toString(),
                          level: room.roomLevel,
                          country: room.country,
                          language: room.language,
                        ),

                        const SizedBox(height: 6),

                        /// اسم الدولة والعلم
                        if (room.country != null && room.country!.isNotEmpty)
                          RoomCountry(
                            countryName: room.country!,
                            flag: '🌍',
                          ),

                        const SizedBox(height: 6),

                        /// الوسوم (Tags)
                        if (room.tags.isNotEmpty)
                          RoomTags(
                            tags: room.tags,
                          ),

                        const SizedBox(height: 6),

                        /// درجة الحرارة والأعضاء النشطين والهدايا
                        RoomHeat(
                          heat: room.heat,
                          online: room.activeUsers,
                          gifts: room.totalGifts,
                        ),

                        const SizedBox(height: 6),

                        /// شريط التقدم لمستوى الغرفة
                        RoomProgress(
                          level: room.roomLevel,
                          heat: room.heat,
                        ),

                        const SizedBox(height: 6),

                        /// الإحصائيات (الحرارة، الأعضاء، الزيارات، الهدايا)
                        RoomStatistics(
                          heat: room.heat,
                          online: room.activeUsers,
                          visitors: room.totalVisitors,
                          gifts: room.totalGifts,
                        ),

                        const Spacer(),

                        /// صور الأعضاء النشطين
                        RoomMembers(
                          members: members,
                          totalMembers: room.activeUsers,
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
