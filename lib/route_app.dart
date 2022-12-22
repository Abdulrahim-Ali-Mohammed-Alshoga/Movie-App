import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/movie_cubit.dart';
import 'package:movies/constants/arguments.dart';
import 'package:movies/data/repository/movies_repository.dart';
import 'package:movies/data/web_services/movies_web_services.dart';
import 'package:movies/presentation/screens/details_movie_screen.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/onboard_screen.dart';
import 'package:movies/presentation/screens/personal_information_screen.dart';
import 'package:movies/presentation/screens/list_movies_screen.dart';
import 'package:movies/presentation/screens/sign_in_screen.dart';
import 'package:movies/presentation/screens/splash_screen.dart';

import 'constants/name_page.dart';

class RouteApp {

  final MovieCubit movieCubit=MovieCubit(MoviesRepository(MoviesWebServices()));
  Route? generateRoute(RouteSettings settings) {print("kll");
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) {
            print(6664);
            return SplashScreen(movieCubit: movieCubit);
          },
        );

      case personalInformationScreen:
        return MaterialPageRoute(
          builder: (context) => PersonalInformationScreen(),
        );
      case scandScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: movieCubit,
                  child: ListMoviesScreen(
                      listMovies: settings.arguments as ListMovies),
                ));
      case singInScreen:
        return MaterialPageRoute(
          builder: (context) => SingInScreen(),
        );
      case detailsMovieScreen:
        return MaterialPageRoute(
          builder: (context) => DetailsMovieScreen(
              detailsMovie: settings.arguments as DetailsMovie),
        );
    }
    return null;
  }
  void dispose(){
movieCubit.close();
  }
}
