import 'package:flutter/material.dart';

import 'color_manager.dart';
class ThemeApp{
  ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: ColorManager.black,
      //تغيير لون glow effect اي اللون الذي يظهر عند السحب للاعلى والاسفل في ListView او SingleChildScrollView وغيرها
      // colorScheme:ColorScheme.fromSwatch().copyWith(secondary: Colors.yellow),
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.black,
        elevation: 0
      ),
      textTheme: const TextTheme(
          headline2:TextStyle(color: ColorManager.white)
      ));
}

