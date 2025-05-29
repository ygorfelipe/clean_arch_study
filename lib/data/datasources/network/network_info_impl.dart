import 'package:internet_connection_checker/internet_connection_checker.dart';

import './network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnection;

  NetworkInfoImpl({required this.internetConnection});

  @override
  Future<bool> get isConnected => internetConnection.hasConnection;
}
