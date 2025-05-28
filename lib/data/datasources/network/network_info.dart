abstract interface class NetworkInfo {
  /// Se true tem connection
  /// Se false não tem connection
  Future<bool> get isConnected;
}
