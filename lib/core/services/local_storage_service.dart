import 'package:shared_preferences/shared_preferences.dart';

final class LocalStorageService {
  LocalStorageService._(this._preferences);

  static LocalStorageService? _instance;

  final SharedPreferences _preferences;

  static LocalStorageService get instance {
    final LocalStorageService? service = _instance;
    if (service == null) {
      throw StateError('LocalStorageService has not been initialized.');
    }

    return service;
  }

  static Future<void> initialize() async {
    _instance ??= LocalStorageService._(
      await SharedPreferences.getInstance(),
    );
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  Future<bool> setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  Future<bool> remove(String key) {
    return _preferences.remove(key);
  }

  Future<bool> clear() {
    return _preferences.clear();
  }
}
