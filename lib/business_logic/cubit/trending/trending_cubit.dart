import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/trending/trending_state.dart';

import '../../../data/models/movie.dart';
import '../../../data/network/network_information.dart';
import '../../../data/repository/trending_movies_repository.dart';

class TrendingMovieCubit extends Cubit<TrendingMovieState> {
  TrendingMovieCubit(this.trendingMoviesRepository, this.networkInformation)
      : super(TrendingMovieInitialState());
  TrendingMoviesRepository trendingMoviesRepository;
  NetworkInfo networkInformation;
  List<Movie> movies = [];
  int numberPage = 1;

  getTrendingMovie() async {

    if (await networkInformation.isConnected) {
      if (movies.isEmpty) {
        emit(TrendingMovieLoading());
      }
      try {
        movies.addAll(await trendingMoviesRepository.getTrendingMovies(
            numberPage: numberPage));
        print(numberPage);
        emit(TrendingMovieSuccess());
        numberPage += 1;
      } catch (e) {
        if (movies.isEmpty) {
          emit(TrendingMovieFailure());
        }
      }
    } else {
      if (movies.isEmpty) {
        emit(TrendingNotConnected());
      }
    }
  }
}
