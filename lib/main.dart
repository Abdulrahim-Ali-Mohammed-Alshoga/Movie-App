import 'package:flutter/material.dart';
import 'package:movies/route_app.dart';

void main() {
  runApp( MyApp(routeApp: RouteApp(),));
}

class MyApp extends StatelessWidget {
  MyApp({super.key,required this.routeApp});
RouteApp routeApp;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,
     onGenerateRoute: routeApp.generateRoute,
    );
  }
}

