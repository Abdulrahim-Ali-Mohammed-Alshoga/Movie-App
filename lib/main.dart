import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies/constants/hive_name.dart';
import 'package:movies/constants/theme_app.dart';
import 'package:movies/presentation/screens/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  await Hive.initFlutter();
  await Hive.openBox(authDb);
  Future.delayed(const Duration(milliseconds: 1))
      .then((value) => FlutterNativeSplash.remove());
  runApp(MyApp(
    isHomeScreen:Hive.box(authDb).get(authTable, defaultValue: false),
    themeApp: ThemeApp(),
  ));
}
