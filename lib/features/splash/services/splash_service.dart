import 'package:joojo_chat/core/services/secure_storage_service.dart';
import 'package:joojo_chat/core/services/service_registry.dart';

final class SplashService {
  SplashService({
    SecureStorageService? secureStorage,
  }) : _secureStorage = secureStorage ?? ServiceRegistry.secureStorage;

  final SecureStorageService _secureStorage;

  Future<bool> isAuthenticated() async {
    return false;
  }

  Future<void> clearSession() async {
    await _secureStorage.delete('session_access_token');
    await _secureStorage.delete('session_refresh_token');
  }
}
