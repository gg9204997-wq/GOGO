abstract final class AppConstants {
  const AppConstants._();

  // =========================
  // App
  // =========================

  static const String appName = 'Joojo Chat';
  static const String appDescription =
      'Professional Voice Chat Platform';

  // =========================
  // Localization
  // =========================

  static const String defaultLocaleCode = 'en';
  static const String arabicLocaleCode = 'ar';

  // =========================
  // Supabase
  // =========================

  static const String supabaseUrl =
      'https://gtiluylrdlfestfnlmzs.supabase.co';

  static const String supabaseAnonKey =
      'sb_publishable_lyZtCv0kZxLZ49phpwlUjQ_p81otaUt';

  // =========================
  // Validation
  // =========================

  static const int maxDisplayNameLength = 32;
  static const int minDisplayNameLength = 2;

  static const int maxBioLength = 160;

  static const int maxRoomNameLength = 48;
  static const int minRoomNameLength = 3;

  // =========================
  // Rooms
  // =========================

  static const int maxRoomMembers = 500;
  static const int maxVoiceSeats = 20;

  // =========================
  // Pagination
  // =========================

  static const int paginationLimit = 20;

  // =========================
  // Search
  // =========================

  static const int searchDebounceMilliseconds = 350;
}