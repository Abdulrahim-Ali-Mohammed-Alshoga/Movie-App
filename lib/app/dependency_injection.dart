import 'package:get_it/get_it.dart';
import 'package:movies/business_logic/cubit/search_movies/search_movie_cubit.dart';
import 'package:movies/data/repository/now_playing_movies_repository.dart';
import 'package:movies/data/repository/search_movies_repository.dart';
import 'package:movies/data/web_services/now_playing_movies_web_service.dart';
import 'package:movies/data/web_services/search_movies_web_services.dart';
import '../business_logic/cubit/genre/genre_cubit.dart';
import '../business_logic/cubit/movie_details/movie_details_cubit.dart';
import '../business_logic/cubit/movies_by_genre/genre_movies_cubit.dart';
import '../business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import '../business_logic/cubit/upcoming_movies/upcoming_movies_cubit.dart';
import '../data/network/network_information.dart';
import '../data/repository/cast_repository.dart';
import '../data/repository/genre_movies_repository.dart';
import '../data/repository/genre_repository.dart';
import '../data/repository/movie_details_repository.dart';
import '../data/repository/upcoming_movies_repository.dart';
import '../data/web_services/cast_web_services.dart';
import '../data/web_services/genre_movies_web_service.dart';
import '../data/web_services/genre_web_service.dart';
import '../data/web_services/movie_details_web service.dart';
import '../data/web_services/upcoming_movies_web_services.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
}

Future<void> initSearchScreen() async {
  // app module, its a module where we put all generic dependencies
  if (!GetIt.I.isRegistered<SearchMoviesWebServices>()) {
    instance.registerFactory<SearchMoviesWebServices>(
        () => SearchMoviesWebServices());

    instance.registerFactory<SearchMoviesRepository>(
        () => SearchMoviesRepository(instance()));

    // network info
    instance.registerFactory<SearchMovieCubit>(
        () => SearchMovieCubit(instance(), instance()));
  }
}

Future<void> initGenreMovies() async {
  if (!GetIt.I.isRegistered<GenreMoviesWebService>()) {
    instance.registerLazySingleton<GenreMoviesWebService>(
            () => GenreMoviesWebService());

    instance.registerLazySingleton<GenreMoviesRepository>(
            () => GenreMoviesRepository(instance()));

    // network info
    instance.registerLazySingleton<GenreMoviesCubit>(
            () => GenreMoviesCubit(instance(),instance()));
  }
}
Future<void> initGenre() async {
  if (!GetIt.I.isRegistered<GenreWebService>()) {
    instance.registerLazySingleton<GenreWebService>(
            () => GenreWebService());

    instance.registerLazySingleton<GenreRepository>(
            () => GenreRepository(instance()));

    // network info
    instance.registerLazySingleton<GenreCubit>(
            () => GenreCubit(instance()));
  }
}

Future<void> initUpcomingMovie() async {
  // app module, its a module where we put all generic dependencies
  if (!GetIt.I.isRegistered<UpcomingMoviesWebServices>()) {
    instance.registerLazySingleton<UpcomingMoviesWebServices>(
        () => UpcomingMoviesWebServices());

    instance.registerLazySingleton<UpcomingMoviesRepository>(
        () => UpcomingMoviesRepository(instance()));

    // network info
    instance.registerLazySingleton<UpcomingMovieCubit>(
        () => UpcomingMovieCubit(instance()));
  }
}

Future<void> initNowPlayingMovies() async {
  // app module, its a module where we put all generic dependencies
  if (!GetIt.I.isRegistered<NowPlayingMoviesWebServices>()) {
    instance.registerLazySingleton<NowPlayingMoviesWebServices>(
        () => NowPlayingMoviesWebServices());

    instance.registerLazySingleton<NowPlayingMoviesRepository>(
        () => NowPlayingMoviesRepository(instance()));

    // network info
    instance.registerLazySingleton<NowPlayingMovieCubit>(
        () => NowPlayingMovieCubit(instance()));
  }
}
Future<void> initMovieDetails() async {
  // app module, its a module where we put all generic dependencies
  if (!GetIt.I.isRegistered<MovieDetailsWebService>()) {
    instance.registerFactory<MovieDetailsWebService>(
        () => MovieDetailsWebService());

    instance.registerFactory<MovieDetailsRepository>(
        () => MovieDetailsRepository(instance()));
    instance.registerFactory<CastWebService>(
            () => CastWebService());
    instance.registerFactory<CastRepository>(
            () => CastRepository(instance()));
    // network info
    instance.registerFactory<MovieDetailsCubit>(
        () => MovieDetailsCubit(instance(),instance(),instance()));
  }
}
