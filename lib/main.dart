import 'package:flutter/material.dart';
import 'package:movies/constants/theme_app.dart';
import 'package:movies/route_app.dart';

void main() {
  runApp( MyApp(routeApp: RouteApp(),themeApp: ThemeApp(),));
}

class MyApp extends StatelessWidget {
  MyApp({super.key,required this.routeApp,required this.themeApp});
RouteApp routeApp;ThemeApp themeApp;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
   debugShowCheckedModeBanner: false,
     onGenerateRoute: routeApp.generateRoute,
     theme: ThemeApp().lightTheme,
    );
  }
}

