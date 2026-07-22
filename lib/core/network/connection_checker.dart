import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:joojo_chat/core/network/network_info.dart';

class ConnectionChecker implements NetworkInfo {
  final InternetConnection _checker =
      InternetConnection();

  @override
  Future<bool> get isConnected async {
    return await _checker.hasInternetAccess;
  }
}