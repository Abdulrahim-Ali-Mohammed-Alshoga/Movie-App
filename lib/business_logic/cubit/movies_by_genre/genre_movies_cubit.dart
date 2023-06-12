import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/genre_movies_state.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/repository/genre_movies_repository.dart';

import '../../../data/network/network_information.dart';

class GenreMoviesCubit extends Cubit<GenreMoviesState> {
  GenreMoviesCubit(this.genreMoviesRepository, this.networkInformation)
      : super(GenreMoviesLoading());
  GenreMoviesRepository genreMoviesRepository;
  NetworkInfo networkInformation;
  List<Movie> movies = [];
  int numberPage = 2;
  int checkGenre = -1;

  void getGenreMovies(int? genre) async {
    if (checkGenre != genre) {
      if (await networkInformation.isConnected) {
        movies.clear();
        numberPage = 2;
        checkGenre = genre!;
        if (movies.isEmpty) {
          emit(GenreMoviesLoading());
        }
        try {
          movies.addAll(await genreMoviesRepository.getGenreMovies(1, genre!));
          emit(GenreMoviesSuccess());
        } catch (e) {
          print(e);
          if (e.toString() == "Connecting timed out [10000ms]") {
          } else {
            emit(GenreMoviesFailure());
          }
        }
      } else {
        emit(GenreMoviesNotConnected());
      }
    }
  }

  void getSameGenreMovies() async {
    if (movies.isEmpty) {
      emit(GenreMoviesLoading());
    }
    try {
      movies.addAll(
          await genreMoviesRepository.getGenreMovies(numberPage, checkGenre));
      emit(GenreMoviesSuccess());
      numberPage += 1;
    } catch (e) {
      print(e);
      if (e.toString() == "Connecting timed out [10000ms]") {
      } else {
        emit(GenreMoviesFailure());
      }
    }
  }
}

