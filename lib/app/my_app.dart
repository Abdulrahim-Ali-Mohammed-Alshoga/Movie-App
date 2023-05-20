import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/upcoming_movies/upcoming_movies_cubit.dart';
import 'package:movies/constants/screen_name.dart';
import 'package:movies/data/web_services/upcoming_movies_web_services.dart';

import '../business_logic/cubit/genre/genre_cubit.dart';
import '../business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import '../constants/arguments.dart';
import '../constants/route_app.dart';
import '../constants/theme_app.dart';
import '../data/repository/genre_repository.dart';
import '../data/repository/now_playing_movies_repository.dart';
import '../data/repository/upcoming_movies_repository.dart';
import '../data/web_services/genre_web_service.dart';
import '../data/web_services/now_playing_movies_web_service.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.themeApp,required this.isSkip, required this.isHomeScreen});

  bool isHomeScreen;
  bool isSkip;
  ThemeApp themeApp;


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
          onGenerateRoute: RouteApp.generateRoute,
          onGenerateInitialRoutes: (String initialRouteName) {
            if(isHomeScreen) {
              return [
                RouteApp.generateRoute(RouteSettings(
                    name: ScreenName.navigationBarScreen,
                    arguments: NavigationBarArgument(isSkip: isHomeScreen)))!,
              ];
            }  else{
              return [
                RouteApp.generateRoute(const RouteSettings(
                    name: ScreenName.onboardScreen,
                ))!,
              ];
            }
          },
          // initialRoute:
          // isHomeScreen ? ScreenName.navigationBarScreen : ScreenName
          //     .onboardScreen,
          title: "Cinema Batool",
          color: Colors.black,
          theme: ThemeApp().lightTheme,
        );
      },
    );
  }
}
