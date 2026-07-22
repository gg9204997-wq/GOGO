// Path: lib/features/home/pages/chat_inbox_page.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatInboxPage extends StatefulWidget {
  const ChatInboxPage({super.key});

  @override
  State<ChatInboxPage> createState() => _ChatInboxPageState();
}

class _ChatInboxPageState extends State<ChatInboxPage> with SingleTickerProviderStateMixin {
  final _supabase = Supabase.instance.client;
  late TabController _tabController;

  static const Color _neonPurple = Color(0xff8A5CFF);
  static const Color _pinkNeon = Color(0xffFF1493);

  late final Stream<List<Map<String, dynamic>>> _systemNotificationsStream;
  late final Stream<List<Map<String, dynamic>>> _friendChatsStream;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final String currentUserId = _supabase.auth.currentUser?.id ?? '';

    // 1. دفق إشعارات النظام الحية الموجهة لهذا المستخدم محقونة بالترتيب
    _systemNotificationsStream = _supabase
        .from('system_notifications')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps.where((row) {
              final target = row['user_id']?.toString();
              return target == null || target == currentUserId;
            }).toList());

    // 2. دفق محادثات ورسائل الأصدقاء الحية من جدول chats مصفاة بدقة متناهية لمنع الـ undefined_method
    _friendChatsStream = _supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .order('updated_at')
        .map((maps) => maps.where((row) {
              return row['sender_id']?.toString() == currentUserId ||
                     row['receiver_id']?.toString() == currentUserId;
            }).toList());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090514),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'صندوق الوارد والرسائل',
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: _neonPurple,
          unselectedLabelColor: Colors.white38,
          indicatorColor: _neonPurple,
          labelStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'إشعارات النظام 📢'),
            Tab(text: 'الأصدقاء 💬'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // 📢 1. تبويب إشعارات النظام الحية والمربوطة بالـ StreamBuilder لايف
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _systemNotificationsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: _neonPurple));
                }
                final notifications = snapshot.data ?? [];
                if (notifications.isEmpty) {
                  return _buildEmptyState('لا توجد تنبيهات من النظام حالياً');
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final item = notifications[index];
                    final title = item['title']?.toString() ?? 'تنبيه من النظام';
                    final body = item['body']?.toString() ?? '';
                    final time = item['time_label']?.toString() ?? 'الآن';

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xff120D1F),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _neonPurple.withValues(alpha: 0.15)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xff1A1435),
                          child: Icon(Icons.campaign_rounded, color: _neonPurple, size: 20),
                        ),
                        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(body, style: const TextStyle(color: Colors.white54, fontSize: 10, fontFamily: 'Cairo', height: 1.4)),
                        ),
                        trailing: Text(time, style: const TextStyle(color: Colors.white24, fontSize: 8, fontFamily: 'Cairo')),
                      ),
                    );
                  },
                );
              },
            ),
            // 💬 2. تبويب رسائل ومحادثات الأصدقاء لايف من جدول المحادثات
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _friendChatsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: _neonPurple));
                }
                
                final chats = snapshot.data ?? [];
                if (chats.isEmpty) {
                  return _buildEmptyState('لا توجد محادثات خاصة حالياً');
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    
                    final String peerName = chat['peer_name']?.toString() ?? 'مستخدم جوجو';
                    final String avatarUrl = chat['peer_avatar']?.toString() ?? 'https://dicebear.com';
                    final String lastMessage = chat['last_message']?.toString() ?? '';
                    final String timeLabel = chat['time_label']?.toString() ?? 'الآن';
                    final int unreadCount = int.tryParse(chat['unread_count']?.toString() ?? '0') ?? 0;
                    final int vipLevel = int.tryParse(chat['vip_level']?.toString() ?? '0') ?? 0;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xff120D1F),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _neonPurple.withValues(alpha: 0.12)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundColor: const Color(0xff1A1435),
                          backgroundImage: CachedNetworkImageProvider(avatarUrl),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                peerName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            if (vipLevel > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFD700),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'VIP $vipLevel',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 7,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: unreadCount > 0 ? Colors.white70 : Colors.white38,
                              fontSize: 10,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              timeLabel,
                              style: const TextStyle(color: Colors.white24, fontSize: 8, fontFamily: 'Cairo'),
                            ),
                            if (unreadCount > 0) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _pinkNeon,
                                ),
                                child: Text(
                                  '$unreadCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        onTap: () {
                          // فتح المحادثة الخاصة التفاعلية حياً لاحقاً
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white38, fontSize: 11, fontFamily: 'Cairo'),
      ),
    );
  }
}
