import 'package:connectivity_plus/connectivity_plus.dart';

final class ConnectivityService {
  ConnectivityService({
    Connectivity? connectivity,
  }) : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Stream<List<ConnectivityResult>> get statusStream =>
      _connectivity.onConnectivityChanged;

  Future<bool> get isConnected async {
    final List<ConnectivityResult> results =
        await _connectivity.checkConnectivity();
    return results.any(_isConnectedResult);
  }

  bool _isConnectedResult(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }
}
