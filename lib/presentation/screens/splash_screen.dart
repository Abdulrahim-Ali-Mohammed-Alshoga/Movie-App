import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:movies/constants/hive_name.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/onboard_screen.dart';

import '../../business_logic/cubit/auth_cubit.dart';
import '../../business_logic/cubit/auth_state.dart';
import '../../business_logic/cubit/genre_cubit.dart';
import '../../business_logic/cubit/movie_cubit.dart';
import '../../data/repository/genre_repository.dart';
import '../../data/repository/movies_repository.dart';
import '../../data/web_services/genre_web_service.dart';
import '../../data/web_services/movies_web_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  bool isCheak = false;
  GenreCubit genreCubit = GenreCubit(GenreRepository(GenreWebService()));
  var box;

  void initState() {
    // TODO: implement initState
    super.initState();
    print("oooooooooooooo");
    box = Hive.box(authDb);
    // BlocProvider.of<AuthCubit>(context).getAuth();
    Future.delayed(const Duration(milliseconds: 1))
        .then((value) => FlutterNativeSplash.remove());
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   genreCubit.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    if (box.get(authTable, defaultValue: false)) {print("k;lm");
      return BlocProvider(create: (context) =>genreCubit,child: HomeScreen(),);
    } else {
      return OnBoardScreen();
    }


    // return BlocBuilder<AuthCubit, AuthState>(
    //   builder: (context, state) {
    //     if (state is AuthSuccess) {
    //       print("iiiiiiiiiiii");
    //       return
    //           // MultiBlocProvider(
    //           // providers: [BlocProvider.value(
    //           //     value: widget.movieCubit),
    //           // ],
    //           // child:
    //           BlocProvider(
    //               create: (context) => genreCubit, child: HomeScreen());
    //     } else {
    //       print("iiiiiiii2222222222");
    //       return const OnBoardScreen();
    //     }
    //   },
    // );
  }
}
