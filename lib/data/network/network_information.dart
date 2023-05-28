import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  late ConnectivityResult connectivityResult;
  ConnectivityResult connectivityResultChange = ConnectivityResult.none;

  NetworkInfo();

  Future<bool> get isConnected async {
    connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  checkChangeConnected() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectivityResultChange = result;
  }

  Future<bool> get getChangeConnected async {
    return connectivityResultChange == ConnectivityResult.wifi ||
        connectivityResultChange == ConnectivityResult.mobile;
  }
}
