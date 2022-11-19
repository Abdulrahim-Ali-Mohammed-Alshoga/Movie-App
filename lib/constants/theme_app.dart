import 'package:flutter/material.dart';
import 'package:movies/constants/mycolor.dart';
class ThemeApp{
  ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: MyColors.black,
      textTheme: TextTheme(
          headline2:TextStyle(color: MyColors.white)
      ));
}

