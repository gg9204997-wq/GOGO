import 'package:joojo_chat/core/services/connectivity_service.dart';
import 'package:joojo_chat/core/services/local_storage_service.dart';
import 'package:joojo_chat/core/services/secure_storage_service.dart';

abstract final class ServiceRegistry {
  ServiceRegistry._();

  static final ConnectivityService connectivity = ConnectivityService();
  static final SecureStorageService secureStorage = SecureStorageService();

  static Future<void> initialize() async {
    await LocalStorageService.initialize();
  }

  static LocalStorageService get localStorage => LocalStorageService.instance;
}
