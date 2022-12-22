import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/movie_state.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/repository/movies_repository.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.moviesRepository) : super(MovieInitialState());
  MoviesRepository moviesRepository;
  List<Movie> movies = [];
  int numberPage = 1;

  void getAllMovies() async {
    print(555557);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      if (movies.isEmpty) {
        emit(MovieLoading());
      }
      try {
        movies.addAll(await moviesRepository.getMovies(numberPage));
        numberPage++;
        emit(MovieSuccess());
      } catch (e) {
        emit(MovieFailure());
      }
    } else {
      if (movies.isEmpty) {
        emit(NotConnected());
      }
    }
  }
}
