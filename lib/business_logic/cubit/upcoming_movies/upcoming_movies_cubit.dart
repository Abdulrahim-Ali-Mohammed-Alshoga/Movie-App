import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/upcoming_movies/upcoming_movies_state.dart';

import '../../../data/models/movie.dart';
import '../../../data/repository/upcoming_movies_repository.dart';

class UpcomingMovieCubit extends Cubit<UpcomingMovieState> {
  UpcomingMovieCubit(this.upcomingMoviesRepository) : super(UpcomingMovieLoading());
  UpcomingMoviesRepository upcomingMoviesRepository;
  List<Movie> movies = [];
  int numberPage=1;
 Future<void>  getAllMovies() async{
          if (movies.isEmpty) {
            emit(UpcomingMovieLoading());
          }
          try {
            movies.addAll(await upcomingMoviesRepository.getUpcomingMovies(numberPage));
            emit(UpcomingMovieSuccess());
            numberPage+=1;
          } catch (e) {
            //
            // if(e.toString()=="Connecting timed out [10000ms]"){
            //
            // }
            if (movies.isEmpty) {
              emit(UpcomingMovieFailure());
            }


          }


  }
}