import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/search_movie_state.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/repository/search_movies_repository.dart';


class SearchMovieCubit extends Cubit<SearchMovieState>{
  SearchMovieCubit(this.searchMoviesRepository):super(SearchMovieInitialState());
  SearchMoviesRepository searchMoviesRepository;
  List<Movie> movies=[];
  int numberPage=1;
  getSearchMovie(String name)async {
    print(555557);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      if (movies.isEmpty) {
        emit(SearchMovieLoading());
      }
      try {
        movies.addAll(await searchMoviesRepository.getSearchMovies(name, numberPage));
        numberPage++;
        emit(SearchMovieSuccess());
      } catch (e) {
        emit(SearchMovieFailure());
      }
    } else {
      if (movies.isEmpty) {
        emit(SearchNotConnected());
      }
    }
  }
}