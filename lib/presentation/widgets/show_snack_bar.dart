import 'package:flutter/material.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/mycolor.dart';

class ShowSnackBarWidget {
  static checkInternetConnectivity(BuildContext context, int network) {
      final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          network ==4 ? const Text("No Connection",style: TextStyle(fontFamily: MyFont.mainFont,fontSize: 17),): const Text("Back Online",style: TextStyle(fontFamily: MyFont.mainFont,fontSize: 17)),
          network ==4 ? const Icon(Icons.wifi_off,color: MyColors.white,size: 24,): const Icon(Icons.wifi,color: MyColors.white,size: 24),

        ],
      ) ,
      behavior: SnackBarBehavior.floating,
      backgroundColor: network == 4 ? MyColors.grey : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
