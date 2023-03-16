import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_state.dart';
import 'package:movies/business_logic/cubit/search_movies/search_movies_state.dart';
import '../../../data/models/movie.dart';
import '../../../data/repository/search_movies_repository.dart';
import '../search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMoviesState> {
  SearchMovieCubit(this.searchMovieRepository) : super(SearchMoviesInitialState());
  SearchMoviesRepository searchMovieRepository;
  List<Movie> movies = [];
  int numberPage=1;
  void getAllMovies({required int numberPage,required String nameMovie}) async{
    print(movies.length);
    print("movies.length");

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      if (movies.isEmpty) {
        emit(SearchMoviesLoading());
      }
      try {
        movies.addAll(await searchMovieRepository.getSearchMovies(name: nameMovie, numberPage: numberPage));

        print(movies);
        print("numberPage");
        emit(SearchMoviesSuccess());
        numberPage+=1;
      } catch (e) {
        print(e);
        if(e.toString()=="Connecting timed out [10000ms]"){

        }
        else{emit(SearchMoviesFailure());}

      }
    } else {
      if (movies.isEmpty) {
        emit(SearchMoviesNotConnected());
      }
    }

  }
}