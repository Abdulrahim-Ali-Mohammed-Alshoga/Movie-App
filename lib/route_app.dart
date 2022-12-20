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
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case personalInformationScreen:
        return MaterialPageRoute(
          builder: (context) => PersonalInformationScreen(),
        );
      case scandScreen:
        return MaterialPageRoute(
          builder: (context) => ListMoviesScreen(listMovies: settings.arguments as ListMovies),
        );
      case singInScreen:
        return MaterialPageRoute(
          builder: (context) => SingInScreen(),
        );
      case detailsMovieScreen:
        return MaterialPageRoute(
          builder: (context) => DetailsMovieScreen(detailsMovie: settings.arguments as DetailsMovie),
        );

    }
  }
}
