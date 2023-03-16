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
  void getAllMovies({required int numberPage}) async{
    print(movies.length);
    print("movies.length");

        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.none) {
          if (movies.isEmpty) {
            emit(UpcomingMovieLoading());
          }
          try {
            movies.addAll(await upcomingMoviesRepository.getUpcomingMovies(numberPage));

            print(movies);
            print("numberPage");
            emit(UpcomingMovieSuccess());
            numberPage+=1;
          } catch (e) {
            print(e);
            if(e.toString()=="Connecting timed out [10000ms]"){

            }
            else{emit(UpcomingMovieFailure());}

          }
        } else {
          if (movies.isEmpty) {
            emit(UpcomingNotConnected());
          }
        }

  }
}