import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:joojo_chat/features/room/providers/room_chat_provider.dart';
import 'package:joojo_chat/features/room/providers/room_member_provider.dart'; 
import 'package:joojo_chat/features/room/providers/room_provider.dart'; 
import 'package:joojo_chat/features/room/repositories/room_message_repository.dart'; 
import 'package:joojo_chat/features/room/repositories/room_member_repository.dart'; 
import 'package:joojo_chat/features/room/repositories/room_repository.dart'; 
import 'widgets/room_body.dart';

/// ═══════════════════════════════════════════════════════════════
/// صفحة الغرفة الرئيسية - إعداد جميع الـ Providers والواجهة
/// ═══════════════════════════════════════════════════════════════

class RoomPage extends StatefulWidget {
  /// إنشاء صفحة الغرفة
  /// 
  /// [roomId] - معرف الغرفة المراد الدخول إليها
  const RoomPage({
    required this.roomId,
    super.key,
  });

  /// معرف الغرفة الفريد
  final String roomId;

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();

    // تعيين الواجهة لتكون شفافة على حواف الشاشة
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    // تخصيص ألوان عناصر النظام
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// ═══ مزود بيانات الغرفة الرئيسية ═══
        ChangeNotifierProvider<RoomProvider>(
          create: (context) => RoomProvider(
            roomRepository: RoomRepository(), 
          )..listenToRoom(widget.roomId),
        ),

        /// ═══ مزود بيانات أعضاء الغرفة ═══
        ChangeNotifierProvider<RoomMemberProvider>(
          create: (context) => RoomMemberProvider(
            roomMemberRepository: RoomMemberRepository(), 
          ),
        ),

        /// ═══ مزود بيانات رسائل الغرفة ═══
        ChangeNotifierProvider<RoomChatProvider>(
          create: (context) => RoomChatProvider(
            roomMessageRepository: RoomMessageRepository(), 
          )..listenToRoomMessages(widget.roomId),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: RoomBody(
          roomId: widget.roomId,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // إعادة تعيين الواجهة عند مغادرة الصفحة
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }
}
