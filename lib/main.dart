import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return ScreenUtilInit(
     designSize: Size(411.4, 843.4),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routeApp.generateRoute,
          theme: ThemeApp().lightTheme,
        );
      },
    );
  }
}

