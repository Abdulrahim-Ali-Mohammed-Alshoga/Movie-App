import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/dependency_injection.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movies/business_logic/cubit/search_movies/search_movie_cubit.dart';
import 'package:movies/business_logic/cubit/upcoming_movies/upcoming_movies_cubit.dart';
import 'package:movies/constants/arguments.dart';
import 'package:movies/presentation/screens/movie__details_screen.dart';
import 'package:movies/presentation/screens/home_screen.dart';
import 'package:movies/presentation/screens/onboard_screen.dart';
import 'package:movies/presentation/screens/personal_information_screen.dart';
import 'package:movies/presentation/screens/list_movies_screen.dart';
import 'package:movies/presentation/screens/search_movies_screen.dart';
import 'package:movies/presentation/screens/sign_in_screen.dart';
import '../business_logic/cubit/genre/genre_cubit.dart';
import '../business_logic/cubit/movie_details/movie_details_cubit.dart';
import '../business_logic/cubit/movies_by_genre/genre_movies_cubit.dart';
import '../data/models/movie_details.dart';
import '../presentation/screens/list_genre_movies_screen.dart';
import '../presentation/screens/navigation_bar_screen.dart';
import 'screen_name.dart';

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
        initGenre();
        initGenreMovies();
        initNowPlayingMovies();
        return MaterialPageRoute(
          builder: (context) {
            NavigationBarArgument navigationBarArgument =
            settings.arguments as NavigationBarArgument;
            return NavigationBarScreen(
              isSkip: navigationBarArgument.isSkip,
            );
          },
        );
      case ScreenName.personalInformationScreen:
        return MaterialPageRoute(
          builder: (context) => PersonalInformationScreen(),
        );
      case ScreenName.listMoviesScreen:
        return MaterialPageRoute(builder: (context) {
          ListMoviesArgument listMovies =
          settings.arguments as ListMoviesArgument;
          return BlocProvider.value(
            value: instance<UpcomingMovieCubit>(),
            child: ListMoviesScreen(listMovies: listMovies),
          );
        });
      case ScreenName.listGenreMoviesScreen:
        return MaterialPageRoute(
          // maintainState: true,
            builder: (context) {
              ListGenreMoviesArgument listMovies =
              settings.arguments as ListGenreMoviesArgument;
              return MultiBlocProvider(providers: [
                BlocProvider.value(
                  value: instance<GenreMoviesCubit>(),
                ),
                BlocProvider.value(
                  value: instance<GenreCubit>()
                    ..startGenre(),
                ),
              ], child: ListGenreMoviesScreen(listGenreMovies: listMovies));
            });
      case ScreenName.singInScreen:
        return MaterialPageRoute(
          builder: (context) =>

          const SingInScreen(),
        );
      case ScreenName.detailsMovieScreen:
        initMovieDetails();
        DetailsMovieArgument detailsMovieArgument = settings.arguments as
        DetailsMovieArgument;
        return MaterialPageRoute(
          builder: (context) =>  BlocProvider<MovieDetailsCubit>(
              create: (context) =>
              instance<MovieDetailsCubit>(),
              child: MovieDetailsScreen(
                  detailsMovie:detailsMovieArgument.detailsMovie),
            )
          );

      case ScreenName.searchMoviesScreen:
        initSearchScreen();
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider<SearchMovieCubit>(
                  create: (context) => instance<SearchMovieCubit>(),
                  child: SearchMovieScreen()),
        );
    }
    return null;
  }
}
