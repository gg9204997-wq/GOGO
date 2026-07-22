// Path: lib/features/home/pages/leaderboards_page.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardsPage extends StatefulWidget {
  final String leaderboardType;
  final String pageTitle;

  const LeaderboardsPage({
    // 🌟 ميكانيزم الإصلاح: تقديم المعاملات required في البداية لحل تحذير always_put_required_named_parameters_first بالملي
    required this.leaderboardType,
    required this.pageTitle,
    super.key,
  });

  @override
  State<LeaderboardsPage> createState() => _LeaderboardsPageState();
}

class _LeaderboardsPageState extends State<LeaderboardsPage> {
  final _supabase = Supabase.instance.client;
  bool _isLoading = true;
  List<Map<String, dynamic>> _leaderboardList = [];

  @override
  void initState() {
    super.initState();
    _fetchLiveLeaderboardData();
  }

  Future<void> _fetchLiveLeaderboardData() async {
    setState(() => _isLoading = true);
    try {
      // 🌟 ميكانيزم الإصلاح: تعريف المتغير بـ PostgrestList الصريح لمنع خطأ argument_type_not_assignable
      PostgrestList? response;

      switch (widget.leaderboardType) {
        case 'celebrities':
          response = await _supabase.from('profiles').select().order('total_support', ascending: false).limit(30);
          break;
        case 'agencies':
          response = await _supabase.from('agencies').select().order('total_points', ascending: false).limit(30);
          break;
        case 'families':
          response = await _supabase.from('families').select().order('family_exp', ascending: false).limit(30);
          break;
        case 'couple_cv':
          response = await _supabase.from('couples').select().order('love_points', ascending: false).limit(30);
          break;
      }

      if (mounted && response != null) {
        setState(() {
          _leaderboardList = List<Map<String, dynamic>>.from(response!);
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = widget.leaderboardType == 'celebrities'
        ? const Color(0xffFF8C00)
        : widget.leaderboardType == 'agencies'
            ? const Color(0xff00BFFF)
            : widget.leaderboardType == 'families'
                ? const Color(0xff2ECC71)
                : const Color(0xffFF1493);

    return Scaffold(
      backgroundColor: const Color(0xff090514),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.pageTitle,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: accentColor))
          : _leaderboardList.isEmpty
              ? const Center(child: Text('لا توجد بيانات صدارة مسجلة حالياً', style: TextStyle(color: Colors.white38, fontFamily: 'Cairo', fontSize: 12)))
              : Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildPodiumSection(accentColor),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: _leaderboardList.length > 3 ? _leaderboardList.length - 3 : 0,
                        itemBuilder: (context, index) {
                          final item = _leaderboardList[index + 3];
                          final int rank = index + 4;
                          return _buildLeaderboardTile(item, rank, accentColor);
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildPodiumSection(Color accentColor) {
    final first = _leaderboardList.isNotEmpty ? _leaderboardList[0] : null;
    final second = _leaderboardList.length > 1 ? _leaderboardList[1] : null;
    final third = _leaderboardList.length > 2 ? _leaderboardList[2] : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (second != null) _buildPodiumUser(second, 2, 54, accentColor),
        const SizedBox(width: 14),
        if (first != null) _buildPodiumUser(first, 1, 68, accentColor),
        const SizedBox(width: 14),
        if (third != null) _buildPodiumUser(third, 3, 50, accentColor),
      ],
    );
  }

  Widget _buildPodiumUser(Map<String, dynamic> item, int rank, double size, Color accentColor) {
    final String name = item['name']?.toString() ?? item['title']?.toString() ?? 'جوجو شات';
    final String avatarUrl = item['avatar_url']?.toString() ?? item['logo']?.toString() ?? item['family_logo']?.toString() ?? 'https://dicebear.com';
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size + 6,
              height: size + 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: rank == 1 ? const Color(0xffFFD700) : accentColor.withValues(alpha: 0.5), width: rank == 1 ? 2.2 : 1.5),
                boxShadow: [BoxShadow(color: accentColor.withValues(alpha: 0.1), blurRadius: 10)],
              ),
              child: CircleAvatar(
                radius: size / 2,
                backgroundColor: const Color(0xff1A1435),
                backgroundImage: CachedNetworkImageProvider(avatarUrl),
              ),
            ),
            Positioned(
              top: -2,
              child: Icon(Icons.workspace_premium_rounded, color: rank == 1 ? const Color(0xffFFD700) : rank == 2 ? const Color(0xffC0C0C0) : const Color(0xffCD7F32), size: 16),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 75,
          child: Text(name, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        ),
      ],
    );
  }

  Widget _buildLeaderboardTile(Map<String, dynamic> item, int rank, Color accentColor) {
    final String name = item['name']?.toString() ?? item['title']?.toString() ?? 'مستخدم جوجو';
    final String avatarUrl = item['avatar_url']?.toString() ?? item['logo']?.toString() ?? item['family_logo']?.toString() ?? 'https://dicebear.com';
    final String score = item['total_support']?.toString() ?? item['total_points']?.toString() ?? item['family_exp']?.toString() ?? item['love_points']?.toString() ?? '0';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xff120D1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accentColor.withValues(alpha: 0.12)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('#$rank', style: TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xff1A1435),
              backgroundImage: CachedNetworkImageProvider(avatarUrl),
            ),
          ],
        ),
        title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wine_bar_rounded, color: Color(0xffFF1493), size: 12),
            const SizedBox(width: 4),
            Text(score, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
