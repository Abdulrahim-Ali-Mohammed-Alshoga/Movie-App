import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/dependency_injection.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movies/business_logic/cubit/search_movies/search_movie_cubit.dart';
import 'package:movies/constants/arguments.dart';
import 'package:movies/data/web_services/search_movies_web_services.dart';
import 'package:movies/presentation/screens/details_movie_screen.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/onboard_screen.dart';
import 'package:movies/presentation/screens/personal_information_screen.dart';
import 'package:movies/presentation/screens/list_movies_screen.dart';
import 'package:movies/presentation/screens/search_movies_screen.dart';
import 'package:movies/presentation/screens/sign_in_screen.dart';
import '../data/network/network_information.dart';
import '../presentation/screens/navigation_bar_screen.dart';
import 'screen_name.dart';
import '../data/repository/search_movies_repository.dart';


class RouteApp {
  RouteApp._();

 static Route<dynamic>? generateRoute(RouteSettings settings) {
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
      case ScreenName.navigationBarScreen:
        initUpcomingMovie();
        initNowPlayingMovies();
        return MaterialPageRoute(
          builder: (context) {
            NavigationBarArgument navigationBarArgument=settings.arguments as NavigationBarArgument;
            return NavigationBarScreen(isSkip:navigationBarArgument.isSkip ,);
          },
        );
      case ScreenName.personalInformationScreen:
        return MaterialPageRoute(
          builder: (context) => PersonalInformationScreen(),
        );
      case ScreenName.listMoviesScreen:
        return MaterialPageRoute(
            builder: (context) {
            ListMoviesArgument listMovies = settings.arguments as ListMoviesArgument;
        return  BlocProvider.value(
          value:instance<NowPlayingMovieCubit>(),
          child: ListMoviesScreen(listMovies: listMovies),
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
              detailsMovie: settings.arguments as DetailsMovieArgument),
        );
      case ScreenName.searchMoviesScreen:
        initSearchScreen();
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SearchMovieCubit>(
              create: (context) => instance<SearchMovieCubit>(),
              child: SearchMovieScreen()),
        );
    }
    return null;
  }


}
