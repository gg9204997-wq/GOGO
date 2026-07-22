// lib/core/router/navigation_shell.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:joojo_chat/core/router/widgets/custom_bottom_nav_bar.dart'; 
import 'package:joojo_chat/core/router/widgets/global_gift_ticker.dart'; 
import 'package:joojo_chat/features/room/models/room_model.dart';
import 'package:joojo_chat/features/room/providers/room_provider.dart';
import 'package:joojo_chat/features/room/repositories/room_repository.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';

// 1. تعديل تهيئة الـ Repository لتتوافق مع الكونستركتور الافتراضي بدون معاملات positional
final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  // إذا كان الـ RoomRepository يحتاج العميل كـ named argument مرره هكذا: RoomRepository(client: Supabase.instance.client)
  // وإذا كان لا يحتاج لشيء، يترك فارغاً هكذا:
  return RoomRepository(); 
});

// 2. ربط الـ RoomProvider
final roomProviderRef = ChangeNotifierProvider<RoomProvider>((ref) {
  final repository = ref.watch(roomRepositoryProvider);
  return RoomProvider(roomRepository: repository);
});

class NavigationShell extends ConsumerStatefulWidget {
  final Widget child; 
  const NavigationShell({required this.child, super.key});

  @override
  ConsumerState<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends ConsumerState<NavigationShell> with SingleTickerProviderStateMixin {
  bool _isRoomMinimized = false;
  bool _isDragging = false;
  Offset _floatingPosition = const Offset(20, 220);

  Future<void> _checkRoomAndNavigate() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      if (mounted) context.go('/login');
      return;
    }
    setState(() => _isRoomMinimized = false);
    try {
      final provider = ref.read(roomProviderRef);
      
      await provider.loadRooms(limit: 100);
      final List<RoomModel> allRooms = provider.rooms;

      final myRoom = allRooms.cast<RoomModel?>().firstWhere(
        (r) => r?.ownerId == user.id,
        orElse: () => null,
      );
      
      if (!mounted) return; 
      if (myRoom != null) {
        context.go('/rooms/${myRoom.id}');
      } else {
        context.go('/rooms/create');
      }
    } catch (e) {
      if (mounted) context.go('/rooms/create');
    }
  }

  void _handleTabSelected(int index) {
    final shell = widget.child as StatefulNavigationShell;
    shell.goBranch(
      index,
      initialLocation: index == shell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color neonPurple = Color(0xff8A5CFF);
    final Size screenSize = MediaQuery.of(context).size;
    final double deleteTargetX = screenSize.width / 2;
    final double deleteTargetY = screenSize.height - 110;
    final shell = widget.child as StatefulNavigationShell;
    final currentIdx = shell.currentIndex;

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      body: Stack(
        children: [
          Positioned.fill(child: widget.child),
          const GlobalGiftTicker(),
          if (_isRoomMinimized)
            Positioned(
              left: _floatingPosition.dx,
              top: _floatingPosition.dy,
              child: Draggable(
                feedback: _buildFloatingRoomWidget(neonPurple, true),
                childWhenDragging: const SizedBox(),
                onDragStarted: () => setState(() => _isDragging = true),
                onDragUpdate: (details) => setState(() => _floatingPosition = details.localPosition),
                onDragEnd: (details) async {
                  setState(() => _isDragging = false);
                  double endX = details.offset.dx;
                  double endY = details.offset.dy;
                  double distance = (endX + 28 - deleteTargetX).abs() + (endY + 28 - deleteTargetY).abs();
                  
                  if (distance < 75) {
                    setState(() => _isRoomMinimized = false);
                    
                    // 🔥 الحل: أخذ الـ Messenger قبل الـ await لمنع الـ Async Gap تماماً
                    final messenger = ScaffoldMessenger.of(context);
                    final provider = ref.read(roomProviderRef);
                    
                    if (provider.currentRoom != null) {
                      await provider.closeCurrentRoom(provider.currentRoom!.id);
                    }
                    
                    if (!mounted) return;
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text(
                          '🚪 تم مغادرة وإغلاق الغرفة الصوتية بنجاح', 
                          style: TextStyle(fontFamily: 'Cairo'),
                        ),
                      ),
                    );
                  } else {
                    if (endX < 10) endX = 10;
                    if (endX > screenSize.width - 70) endX = screenSize.width - 70;
                    if (endY < 60) endY = 60;
                    if (endY > screenSize.height - 150) endY = screenSize.height - 150;
                    setState(() => _floatingPosition = Offset(endX, endY));
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    setState(() => _isRoomMinimized = false);
                    context.go('/rooms/active'); 
                  },
                  child: _buildFloatingRoomWidget(neonPurple, false),
                ),
              ),
            ),
          if (_isDragging && _isRoomMinimized)
            Positioned(
              left: 0, right: 0, top: deleteTargetY,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 54, height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffFF1493).withAlpha((0.2 * 255).toInt()),
                    border: Border.all(color: const Color(0xffFF1493), width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
                ),
              ),
            ),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: CustomBottomNavBar(
              currentIndex: currentIdx,
              onTabSelected: _handleTabSelected,
              onMicPressed: _checkRoomAndNavigate,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingRoomWidget(Color neonColor, bool isDragging) {
    return Container(
      width: 56, height: 54,
      decoration: BoxDecoration(
        color: const Color(0xff1A0B36),
        shape: BoxShape.circle,
        border: Border.all(color: isDragging ? const Color(0xffFF1493) : neonColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: (isDragging ? const Color(0xffFF1493) : neonColor).withAlpha((0.3 * 255).toInt()), 
            blurRadius: 10, 
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(child: Icon(Icons.headset_mic_rounded, color: Colors.white, size: 24)),
    );
  }
}