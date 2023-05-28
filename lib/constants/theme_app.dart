import 'package:flutter/material.dart';
import 'package:movies/constants/mycolor.dart';
class ThemeApp{
  ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: MyColors.black,
      //تغيير لون glow effect اي اللون الذي يظهر عند السحب للاعلى والاسفل في ListView او SingleChildScrollView وغيرها
      // colorScheme:ColorScheme.fromSwatch().copyWith(secondary: Colors.yellow),
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.black,
        elevation: 0
      ),
      textTheme: TextTheme(
          headline2:TextStyle(color: MyColors.white)
      ));
}

