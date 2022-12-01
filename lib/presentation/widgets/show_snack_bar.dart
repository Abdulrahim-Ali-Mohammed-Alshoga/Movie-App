import 'package:flutter/material.dart';
import 'package:movies/constants/mycolor.dart';

class ShowSnackBarWidget {
  static checkInternetConnectivity(BuildContext context,int network) {
    final snackBar= SnackBar(
      content: Center(child:network==1? Text("No Connection"):Text("Back Online")),
       behavior: SnackBarBehavior.floating,
      backgroundColor:network==1? MyColors.grey:Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// checkInternetConnectivityDialog() {
//   showDialog(builder: (context) {
//     return AlertDialog(
//       title: Text("Network connection"),
//     );
//   }, context: context,);
// }

}