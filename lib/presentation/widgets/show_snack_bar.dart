import 'package:flutter/material.dart';
import 'package:movies/constants/color_manager.dart';
import 'package:movies/constants/font.dart';

class ShowSnackBarWidget {
  static GlobalKey<ScaffoldMessengerState> key =
GlobalKey<ScaffoldMessengerState>();
  static checkInternetConnectivity(BuildContext context, int network) {
      final snackBar = SnackBar(
      duration: const Duration(seconds: 3),

      content:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          network ==4 ? const Text("No Connection",style: TextStyle(fontFamily: MyFont.mainFont,fontSize: 17),): const Text("Back Online",style: TextStyle(fontFamily: MyFont.mainFont,fontSize: 17)),
          network ==4 ? const Icon(Icons.wifi_off,color: ColorManager.white,size: 24,): const Icon(Icons.wifi,color: ColorManager.white,size: 24),

        ],
      ) ,
      behavior: SnackBarBehavior.floating,
      backgroundColor: network == 4 ? ColorManager.grey : ColorManager.green,
    );
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
key.currentState!.showSnackBar(snackBar);
  }
}


// class SnackBarGlobal {
//   static GlobalKey<ScaffoldMessengerState> key =
//   GlobalKey<ScaffoldMessengerState>();
//
//   static void show(String message) {
//     key.currentState!
//       ..hideCurrentSnackBar()
//       ..showSnackBar(SnackBar(content: Text(message)));
//   }
// }