// Path: lib/features/home/pages/search_page.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late TabController _tabController;
  final _supabase = Supabase.instance.client;

  static const Color _neonPurple = Color(0xff8A5CFF);
  bool _isLoading = false;

  List<Map<String, dynamic>> _searchResultsRooms = [];
  List<Map<String, dynamic>> _searchResultsUsers = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _performLiveDatabaseSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResultsRooms.clear();
        _searchResultsUsers.clear();
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      final textQuery = query.trim();

      final roomsData = await _supabase
          .from('rooms')
          .select()
          .or('title.ilike.%$textQuery%,id.ilike.%$textQuery%')
          .limit(15);

      final usersData = await _supabase
          .from('profiles')
          .select()
          .or('name.ilike.%$textQuery%,user_id.ilike.%$textQuery%')
          .limit(15);

      if (mounted) {
        setState(() {
          _searchResultsRooms = List<Map<String, dynamic>>.from(roomsData);
          _searchResultsUsers = List<Map<String, dynamic>>.from(usersData);
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
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
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'البحث المطور',
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xff120D1F),
                  borderRadius: BorderRadius.circular(23),
                  border: Border.all(color: _neonPurple.withValues(alpha: 0.25), width: 1.2),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _performLiveDatabaseSearch,
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Cairo'),
                  decoration: InputDecoration(
                    hintText: 'أدخل رقم الـ ID أو اسم الغرفة والمستخدم...',
                    hintStyle: const TextStyle(color: Colors.white38, fontSize: 11.5, fontFamily: 'Cairo'),
                    prefixIcon: const Icon(Icons.search_rounded, color: _neonPurple, size: 20),
                    suffixIcon: _searchController.text.trim().isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.cancel_rounded, color: Colors.white30, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              _performLiveDatabaseSearch('');
                            },
                          ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: _neonPurple,
              unselectedLabelColor: Colors.white38,
              indicatorColor: _neonPurple,
              labelStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'الغرف الصوتية 🎙️'),
                Tab(text: 'المستخدمين 👑'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: _neonPurple))
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        // الحل النهائي: استخدام if/else كـ Collection elements لتجنب التنبيهات
                        if (_searchResultsRooms.isEmpty)
                          _buildEmptyState('لا توجد غرف تطابق بحثك حالياً')
                        else
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _searchResultsRooms.length,
                            itemBuilder: (context, index) {
                              final room = _searchResultsRooms[index];
                              return _buildRoomResultTile(room);
                            },
                          ),
                        if (_searchResultsUsers.isEmpty)
                          _buildEmptyState('لا يوجد مستخدمون يطابقون بحثك حالياً')
                        else
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _searchResultsUsers.length,
                            itemBuilder: (context, index) {
                              final user = _searchResultsUsers[index];
                              return _buildUserResultTile(user);
                            },
                          ),
                      ],
                    ),
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

  Widget _buildRoomResultTile(Map<String, dynamic> room) {
    final title = room['title']?.toString() ?? 'غرفة بث مباشر';
    final roomId = room['id']?.toString() ?? '00000';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xff120D1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _neonPurple.withValues(alpha: 0.15)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff1A1435)),
          child: const Icon(Icons.graphic_eq_rounded, color: _neonPurple, size: 20),
        ),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        subtitle: Text('ID: $roomId', style: const TextStyle(color: Colors.white38, fontSize: 9.5, fontWeight: FontWeight.bold)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [_neonPurple, Color(0xff5214CC)]), borderRadius: BorderRadius.circular(14)),
          child: const Text('دخول 🚪', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        ),
        onTap: () {
          context.go('/rooms/$roomId');
        },
      ),
    );
  }

  Widget _buildUserResultTile(Map<String, dynamic> user) {
    final name = user['name']?.toString() ?? 'جوجو شات';
    final uid = user['user_id']?.toString() ?? '00000000';
    final avatar = user['avatar_url']?.toString() ?? 'https://dicebear.com';
    final vip = int.tryParse(user['vip_level']?.toString() ?? '0') ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xff120D1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xff00BFFF).withValues(alpha: 0.15)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xff1A1435),
          backgroundImage: CachedNetworkImageProvider(avatar),
        ),
        title: Row(
          children: [
            Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
            const SizedBox(width: 6),
            if (vip > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(color: const Color(0xffFFD700), borderRadius: BorderRadius.circular(4)),
                child: Text('VIP $vip', style: const TextStyle(color: Colors.black, fontSize: 7, fontWeight: FontWeight.w900)),
              ),
          ],
        ),
        subtitle: Text('ID: $uid', style: const TextStyle(color: Colors.white38, fontSize: 9.5, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
        onTap: () {},
      ),
    );
  }
}