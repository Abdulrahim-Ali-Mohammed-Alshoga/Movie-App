import 'package:flutter/material.dart';
import 'package:movies/presentation/screens/onboard_screen.dart';

import 'constants/name_page.dart';

class RouteApp{
  Route? generateRoute(RouteSettings settings){
    switch (settings.name){
      case onBoardScreen:
        return MaterialPageRoute(builder: (context) => OnBoardScreen(),);
    }
  }
}