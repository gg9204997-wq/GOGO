import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:joojo_chat/features/room/providers/room_message_provider.dart'; 
import 'package:joojo_chat/features/room/providers/room_member_provider.dart'; 
import 'package:joojo_chat/features/room/providers/room_provider.dart'; 
import 'package:joojo_chat/features/room/repositories/room_message_repository.dart'; 
import 'package:joojo_chat/features/room/repositories/room_member_repository.dart'; 
import 'package:joojo_chat/features/room/repositories/room_repository.dart'; 
import 'package:joojo_chat/features/room/widgets/room_body.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({
    required this.roomId,
    super.key,
  });

  final String roomId;

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

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
        ChangeNotifierProvider<RoomProvider>(
          create: (context) => RoomProvider(
            roomRepository: RoomRepository(), 
          )..listenToRoom(widget.roomId),
        ),
        ChangeNotifierProvider<RoomMemberProvider>(
          create: (context) => RoomMemberProvider(
            roomMemberRepository: RoomMemberRepository(), 
          ),
        ),
        // تم دمج اسم الكلاس الفعلي (RoomChatProvider) مع اسم الـ Repository المطلوب (roomMessageRepository)
        ChangeNotifierProvider<RoomChatProvider>(
          create: (context) => RoomChatProvider(
            roomMessageRepository: RoomMessageRepository(), 
          )..listenToRoomMessages(widget.roomId), // تفعيل جلب رسائل الغرفة بشكل تلقائي ومباشر عند الدخول
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
}
