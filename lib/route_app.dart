import 'package:flutter/material.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/onboard_screen.dart';
import 'package:movies/presentation/screens/personal_information_screen.dart';
import 'package:movies/presentation/screens/sing_in_screen.dart';
import 'package:movies/presentation/screens/splash_screen.dart';

import 'constants/name_page.dart';

class RouteApp {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoardScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case personalInformationScreen:
        return MaterialPageRoute(
          builder: (context) => PersonalInformationScreen(),
        );
      case singInScreen:
        return MaterialPageRoute(
          builder: (context) => SingInScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
    }
  }
}
