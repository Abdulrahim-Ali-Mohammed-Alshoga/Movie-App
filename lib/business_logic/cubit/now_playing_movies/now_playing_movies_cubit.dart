import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_state.dart';
import '../../../data/models/movie.dart';
import '../../../data/repository/now_playing_movies_repository.dart';

class NowPlayingMovieCubit extends Cubit<NowPlayingMovieState> {
  NowPlayingMovieCubit(this.nowPlayingMoviesRepository) : super(NowPlayingMovieInitialState());
  NowPlayingMoviesRepository nowPlayingMoviesRepository;
  List<Movie> movies = [];
  int numberPage=1;
  Future<void> getAllMovies() async{
      if (movies.isEmpty) {
        emit(NowPlayingMovieLoading());
      }
      try {
        movies.addAll(await nowPlayingMoviesRepository.getNewPlayingMovies(numberPage));
        emit(NowPlayingMovieSuccess());
        numberPage+=1;
      } catch (e) {

        if (movies.isEmpty) {
          emit(NowPlayingMovieFailure());
        }
      //  else{emit(NowPlayingMovieFailure());}

      }


  }
}