import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/search_movies/search_movie_state.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/repository/search_movies_repository.dart';

import '../../../data/network/network_information.dart';


class SearchMovieCubit extends Cubit<SearchMovieState>{
  SearchMovieCubit(this.searchMoviesRepository,this.networkInformation):super(SearchMovieInitialState());
  SearchMoviesRepository searchMoviesRepository;
  NetworkInfo networkInformation;
  List<Movie> movies=[];


  getSearchMovie({required String nameMovie})async {
    movies.clear();
    if (await networkInformation.isConnected) {
      if (movies.isEmpty) {
        emit(SearchMovieLoading());
      }
      try {

        movies.addAll(await searchMoviesRepository.getSearchMovies(name: nameMovie));

        emit(SearchMovieSuccess());
      } catch (e) {
        print(e);
        emit(SearchMovieFailure());
      }
    } else {
      if (movies.isEmpty) {
        emit(SearchNotConnected());
      }
    }
  }
}