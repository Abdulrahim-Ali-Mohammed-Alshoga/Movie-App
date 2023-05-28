import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies/app/app_hive.dart';
import 'package:movies/business_logic/cubit/network/network_cubit.dart';
import 'package:movies/constants/hive_name.dart';
import 'package:movies/constants/theme_app.dart';
import 'package:movies/app/my_app.dart';
import 'package:movies/data/network/network_information.dart';

import 'app/dependency_injection.dart';
import 'business_logic/cubit/favorite/favorite_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initAppModule();
//  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await AppHive().getInitHive;
  await initAppModule();
  Future.delayed(const Duration(milliseconds: 1))
      .then((value) => FlutterNativeSplash.remove());
  var box = Hive.box(AuthHiveDB.authDB);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<FavoriteCubit>(
      create: (context) => FavoriteCubit(),
    ),
    BlocProvider<NetworkCubit>(
      create: (context) => NetworkCubit(),
    )
  ], child: MyApp(
    isHomeScreen: box.get(AuthHiveDB.isAuthTable, defaultValue: false),
    themeApp: ThemeApp(),
    isSkip: box.get(AuthHiveDB.isSkip, defaultValue: false),
  )));
}
