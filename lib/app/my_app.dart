import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/network/network_cubit.dart';
import 'package:movies/business_logic/cubit/network/network_state.dart';
import 'package:movies/constants/screen_name.dart';
import '../constants/arguments.dart';
import '../constants/color_manager.dart';
import '../constants/route_app.dart';
import '../constants/theme_app.dart';
import '../presentation/widgets/show_snack_bar.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.themeApp,required this.isSkip, required this.isHomeScreen});

  bool isHomeScreen;
  bool isSkip;
  ThemeApp themeApp;
  final _inputKey = GlobalKey<FormState>();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(411.4, 843.4),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocListener<NetworkCubit,NetworkState>(
          listener: (contextt, state) {
if(state is NetworkIsConnected)
  {
   // checkInternetConnectivity(contextt,4);
    ShowSnackBarWidget.checkInternetConnectivity(context, 0);
  }
else if(state is NetworkIsNotConnected)
{
  ShowSnackBarWidget.checkInternetConnectivity(context,4);
}
          },
          child: MaterialApp(
            scaffoldMessengerKey: ShowSnackBarWidget.key,
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
            color: ColorManager.black,
            theme: ThemeApp().lightTheme,
          ),
        );
      },
    );
  }
}

