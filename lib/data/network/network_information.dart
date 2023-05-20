import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo{
  late  ConnectivityResult connectivityResult;
  NetworkInfo();


  Future<bool> get isConnected async{
   connectivityResult= await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

}