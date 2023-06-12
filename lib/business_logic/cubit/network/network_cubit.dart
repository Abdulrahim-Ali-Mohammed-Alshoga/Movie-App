import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/network/network_state.dart';
class NetworkCubit extends Cubit<NetworkState> {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool isStartApp = true;

  NetworkCubit() : super(NetworkInitialState()) {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        if ((event == ConnectivityResult.wifi ||
                event == ConnectivityResult.mobile) &&
            !isStartApp) {
          emit(NetworkIsConnected());
        } else if (!isStartApp) {
          emit(NetworkIsNotConnected());
        }
        isStartApp = false;
      },
    );
  }
}
//   NetworkInfo networkInfo;
//    getChangeConnected() async{
//     networkInfo.checkChangeConnected();
//     print('object');
//     updateConnectionStatus();
//     }
// Future<void> updateConnectionStatus() async{
//  if(await networkInfo.getChangeConnected){
//    emit(NetworkIsConnected());
//  }
//  else {
//    emit(NetworkIsNotConnected());
//  }
// }
