import 'package:flutter/material.dart';
import 'package:movies/constants/mycolor.dart';
class ThemeApp{
  ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: MyColors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.black,
        elevation: 0
      ),
      textTheme: TextTheme(
          headline2:TextStyle(color: MyColors.white)
      ));
}

