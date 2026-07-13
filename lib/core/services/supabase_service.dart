import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;

  static GoTrueClient get auth => client.auth;

  static User? get currentUser => auth.currentUser;

  static bool get isLoggedIn => currentUser != null;
}