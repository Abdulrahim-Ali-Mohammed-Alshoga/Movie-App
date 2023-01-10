import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies/business_logic/cubit/auth_cubit.dart';
import 'package:movies/constants/hive_name.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/constants/theme_app.dart';
import 'package:movies/route_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  await Hive.initFlutter();
  await Hive.openBox(authDb);
  runApp(MyApp(routeApp: RouteApp(), themeApp: ThemeApp(),));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.routeApp, required this.themeApp});

  RouteApp routeApp;
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
          onGenerateRoute: routeApp.generateRoute,
          title: "Cinema Batool",
color: Colors.black,
          theme: ThemeApp().lightTheme,
        );
      },
    );
  }
}

