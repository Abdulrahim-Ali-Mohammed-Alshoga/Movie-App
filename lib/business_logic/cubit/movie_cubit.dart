import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/movie_state.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/repository/movies_repository.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.moviesRepository) : super(MovieLoading());
  MoviesRepository moviesRepository;
  List<Movie> movies = [];
  int numberPage=1;
  void getAllMovies(int genre, int time) async{
    print(movies.length);
    print("movies.length");
    Timer(
      Duration(seconds: time),
      () async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.none) {
          if (movies.isEmpty) {
            emit(MovieLoading());
          }
          try {
           movies.addAll(await moviesRepository.getMovies(numberPage, genre));

            print(numberPage);
            emit(MovieSuccess());
            numberPage+=1;
          } catch (e) {
            print(e);
            if(e.toString()=="Connecting timed out [10000ms]"){

            }
            else{emit(MovieFailure());}

          }
        } else {
          if (movies.isEmpty) {
            emit(NotConnected());
          }
        }
      },
    );
  }
}
