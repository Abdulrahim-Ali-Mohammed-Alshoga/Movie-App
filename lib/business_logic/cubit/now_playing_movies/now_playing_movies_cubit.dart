import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_state.dart';
import 'package:movies/business_logic/cubit/upcoming_movies/upcoming_movies_state.dart';

import '../../../data/models/movie.dart';
import '../../../data/repository/now_playing_movies_repository.dart';
import '../../../data/repository/upcoming_movies_repository.dart';

class NowPlayingMovieCubit extends Cubit<NowPlayingMovieState> {
  NowPlayingMovieCubit(this.nowPlayingMoviesRepository) : super(NowPlayingMovieInitialState());
  NowPlayingMoviesRepository nowPlayingMoviesRepository;
  List<Movie> movies = [];
  int numberPage=1;
  void getAllMovies({required int numberPage}) async{
    print(movies.length);
    print("movies.length");

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      if (movies.isEmpty) {
        emit(NowPlayingMovieLoading());
      }
      try {
        movies.addAll(await nowPlayingMoviesRepository.getNewPlayingMovies(numberPage));

        print(movies);
        print("numberPage");
        emit(NowPlayingMovieSuccess());
        numberPage+=1;
      } catch (e) {
        print(e);
        if(e.toString()=="Connecting timed out [10000ms]"){

        }
        else{emit(NowPlayingMovieFailure());}

      }
    } else {
      if (movies.isEmpty) {
        emit(NowPlayingNotConnected());
      }
    }

  }
}