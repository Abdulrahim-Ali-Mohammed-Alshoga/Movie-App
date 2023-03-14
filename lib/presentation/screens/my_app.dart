import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/screen_name.dart';

import '../../business_logic/cubit/genre_cubit.dart';
import '../../constants/route_app.dart';
import '../../constants/theme_app.dart';
import '../../data/repository/genre_repository.dart';
import '../../data/web_services/genre_web_services.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.themeApp,required this.isHomeScreen});
bool isHomeScreen;
  ThemeApp themeApp;
  GenreCubit genreCubit = GenreCubit(GenreRepository(GenreWebServices()));
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 843.4),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocProvider(
          create: (context) => genreCubit,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteApp.generateRoute,
            initialRoute:isHomeScreen?ScreenName.homeScreen:ScreenName.onboardScreen ,
            title: "Cinema Batool",
            color: Colors.black,
            theme: ThemeApp().lightTheme,
          ),
        );
      },
    );
  }
}