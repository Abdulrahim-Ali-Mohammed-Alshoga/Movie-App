import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/genre_cubit.dart';
import 'package:movies/business_logic/cubit/movie_cubit.dart';
import 'package:movies/business_logic/cubit/search_movie_cubit.dart';
import 'package:movies/constants/arguments.dart';
import 'package:movies/data/repository/movies_repository.dart';
import 'package:movies/data/web_services/movies_web_services.dart';
import 'package:movies/data/web_services/search_movies_web_services.dart';
import 'package:movies/presentation/screens/details_movie_screen.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/onboard_screen.dart';
import 'package:movies/presentation/screens/personal_information_screen.dart';
import 'package:movies/presentation/screens/list_movies_screen.dart';
import 'package:movies/presentation/screens/search_movies_screen.dart';
import 'package:movies/presentation/screens/sign_in_screen.dart';
import 'package:movies/presentation/screens/splash_screen.dart';

import 'screen_name.dart';
import '../data/repository/genre_repository.dart';
import '../data/repository/search_movies_repository.dart';
import '../data/web_services/genre_web_services.dart';

class RouteApp {
  RouteApp._();

 static Route? generateRoute(RouteSettings settings) {
    print("kll");
    switch (settings.name) {
      case ScreenName.homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        );
      case ScreenName.onboardScreen:
        return MaterialPageRoute(
          builder: (context) {
            return OnBoardScreen();
          },
        );
      case ScreenName.personalInformationScreen:
        return MaterialPageRoute(
          builder: (context) => PersonalInformationScreen(),
        );
      case ScreenName.listMoviesScreen:
        return MaterialPageRoute(

            builder: (context) {
              ListMovies listMovies = settings.arguments as ListMovies;
        return  BlocProvider.value(
          value: listMovies.movieCubit,
          child: ListMoviesScreen(
                listMovies: listMovies ),
        );
        }
                );
      case ScreenName.singInScreen:
        return MaterialPageRoute(
          builder: (context) => SingInScreen(),
        );
      case ScreenName.detailsMovieScreen:
        return MaterialPageRoute(
          builder: (context) => DetailsMovieScreen(
              detailsMovie: settings.arguments as DetailsMovie),
        );
      case ScreenName.searchMoviesScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SearchMovieCubit>(
              create: (context) => SearchMovieCubit(
                  SearchMoviesRepository(SearchMoviesWebServices())),
              child: SearchMovieScreen()),
        );
    }
    return null;
  }


}
