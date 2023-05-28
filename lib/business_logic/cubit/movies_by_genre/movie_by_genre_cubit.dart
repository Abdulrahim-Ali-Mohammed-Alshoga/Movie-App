import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/movie_by_genre_state.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/repository/movies_repository.dart';

class MoviesByGenreCubit extends Cubit<MoviesByGenreState> {
  MoviesByGenreCubit(this.moviesByGenreRepository) : super(MoviesByGenreLoading());
  MoviesByGenreRepository moviesByGenreRepository;
  List<Movie> movies = [];
  int numberPage=1;
  int checkGenre=-1;
  void getMoviesByGenre(int? genre) async{

if(checkGenre!=genre){
  movies.clear();
  numberPage=1;
checkGenre=genre!;
    if (movies.isEmpty) {
      emit(MoviesByGenreLoading());
    }
    try {

      movies.addAll(await moviesByGenreRepository.getMoviesByGenre(numberPage,genre!));
      emit(MoviesByGenreSuccess());
      numberPage+=1;
    } catch (e) {
      print(e);
      if(e.toString()=="Connecting timed out [10000ms]"){

      }
      else{emit(MoviesByGenreFailure());}

    }

  }
  }
}
