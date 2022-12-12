import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/onboard_screen.dart';

import '../../business_logic/cubit/auth_cubit.dart';
import '../../business_logic/cubit/auth_state.dart';
import '../../business_logic/cubit/movie_cubit.dart';
import '../../data/repository/movies_repository.dart';
import '../../data/web_services/movies_web_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AuthCubit>(context).getAuth();
    Future.delayed(const Duration(milliseconds: 1000)).then((value) => FlutterNativeSplash.remove());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit,AuthState>(builder: (context, state) {
      if(state is AuthSuccess){
     return BlocProvider(create: (context) => MovieCubit(MoviesRepository(MoviesWebServices())),child: HomeScreen());
      }
      else{
       return const OnBoardScreen();
      }
    },);
  }
}
