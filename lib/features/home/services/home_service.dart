import 'package:supabase_flutter/supabase_flutter.dart';

class HomeService {
  HomeService._();

  static final HomeService instance = HomeService._();

  final SupabaseClient _supabase = Supabase.instance.client;

  //==============================
  // Current Profile
  //==============================

  Future<Map<String, dynamic>?> getProfile() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return null;

    return await _supabase
        .from('profiles')
        .select()
        .eq('user_id', user.id)
        .maybeSingle();
  }

  //==============================
  // Wallet
  //==============================

  Future<Map<String, dynamic>?> getWallet() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return null;

    return await _supabase
        .from('wallet')
        .select()
        .eq('user_id', user.id)
        .maybeSingle();
  }

  //==============================
  // Banner
  //==============================

  Future<List<Map<String, dynamic>>> getBanners() async {
    final response = await _supabase
        .from('banners')
        .select()
        .eq('is_active', true)
        .order('sort_order');

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Categories
  //==============================

  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await _supabase
        .from('categories')
        .select()
        .eq('is_active', true)
        .order('sort_order');

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Rooms
  //==============================

  Future<List<Map<String, dynamic>>> getRooms() async {
    final response = await _supabase
        .from('rooms')
        .select()
        .eq('is_closed', false)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Room Seats
  //==============================

  Future<List<Map<String, dynamic>>> getRoomSeats(
      String roomId) async {
    final response = await _supabase
        .from('room_seats')
        .select()
        .eq('room_id', roomId)
        .order('seat_number');

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Families
  //==============================

  Future<List<Map<String, dynamic>>> getFamilies() async {
    final response = await _supabase
        .from('families')
        .select()
        .order('level', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Agencies
  //==============================

  Future<List<Map<String, dynamic>>> getAgencies() async {
    final response = await _supabase
        .from('agencies')
        .select()
        .order('level', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Top Rich
  //==============================

  Future<List<Map<String, dynamic>>> getTopRich() async {
    final response = await _supabase
        .from('profiles')
        .select()
        .order('diamonds', ascending: false)
        .limit(20);

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Top Hosts
  //==============================

  Future<List<Map<String, dynamic>>> getTopHosts() async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('is_host', true)
        .order('xp', ascending: false)
        .limit(20);

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Top VIP
  //==============================

  Future<List<Map<String, dynamic>>> getTopVip() async {
    final response = await _supabase
        .from('profiles')
        .select()
        .gt('vip_level', 0)
        .order('vip_level', ascending: false)
        .limit(20);

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // Celebrities
  //==============================

  Future<List<Map<String, dynamic>>> getCelebrities() async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('verified', true)
        .order('followers', ascending: false)
        .limit(20);

    return List<Map<String, dynamic>>.from(response);
  }

  //==============================
  // App Settings
  //==============================

  Future<Map<String, dynamic>?> getSettings() async {
    return await _supabase
        .from('app_settings')
        .select()
        .limit(1)
        .maybeSingle();
  }
}