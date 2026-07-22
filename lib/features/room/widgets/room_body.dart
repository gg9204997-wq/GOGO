import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:joojo_chat/features/room/providers/room_provider.dart';
import 'package:joojo_chat/features/room/providers/room_member_provider.dart';

import 'room_background.dart';
import 'room_chat.dart';
import 'room_header.dart';
import 'room_mic_grid.dart';
import 'room_user_bar.dart';
import 'header/members/member_avatar.dart';

/// ═══════════════════════════════════════════════════════════════
/// جسم الغرفة - يحتوي على جميع عناصر الغرفة الرئيسية
/// ═══════════════════════════════════════════════════════════════

class RoomBody extends StatelessWidget {
  /// إنشاء جسم الغرفة
  /// 
  /// [roomId] - معرف الغرفة المراد عرضها
  const RoomBody({
    super.key,
    required this.roomId,
  });

  /// معرف الغرفة الفريد
  final String roomId;

  @override
  Widget build(BuildContext context) {
    /// الحصول على حالة التحميل من الـ Provider
    final isLoading =
        context.select((RoomProvider p) => p.isLoading);

    /// الحصول على رسالة الخطأ من الـ Provider
    final errorMessage =
        context.select((RoomProvider p) => p.errorMessage);

    /// الحصول على بيانات الغرفة الحالية من الـ Provider
    final currentRoom =
        context.select((RoomProvider p) => p.currentRoom);

    /// الحصول على أعضاء الغرفة من الـ Provider
    final members =
        context.watch<RoomMemberProvider>().members;

    /// ═══ حالة التحميل ═══
    if (isLoading && currentRoom == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    /// ═══ حالة الخطأ ═══
    if (errorMessage != null && currentRoom == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'حدث خطأ: $errorMessage',
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    /// ═══ حالة النجاح - عرض محتوى الغرفة ═══
    if (currentRoom == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'لم يتم العثور على بيانات الغرفة',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    /// تحويل قائمة الأعضاء إلى MemberAvatarData للعرض في الـ Header
    final memberAvatars = members
        .map(
          (member) => MemberAvatarData(
            imageUrl: member.profileImage,
            isOnline: member.isOnline,
            isVip: member.isVip,
            isHost: member.isHost,
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// ═══ الخلفية ═══
          const RoomBackground(),

          /// ═══ المحتوى الرئيسي ═══
          SafeArea(
            child: Column(
              children: [
                /// رأس الغرفة
                RoomHeader(
                  room: currentRoom,
                  members: memberAvatars,
                  onShare: () {
                    // TODO: تطبيق وظيفة المشاركة
                  },
                  onMinimize: () {
                    // TODO: تطبيق وظيفة التصغير
                  },
                  onExit: () {
                    Navigator.pop(context);
                  },
                ),

                /// شريط معلومات الأعضاء
                const RoomUserBar(),

                const SizedBox(height: 8),

                /// شبكة المقاعد الصوتية
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: RoomMicGrid(),
                  ),
                ),
              ],
            ),
          ),

          /// ═══ نافذة الدردشة ═══
          RoomChat(
            isExpanded: false,
            onToggleExpand: () {
              // TODO: تطبيق وظيفة توسيع الدردشة
            },
          ),
        ],
      ),
    );
  }
}
