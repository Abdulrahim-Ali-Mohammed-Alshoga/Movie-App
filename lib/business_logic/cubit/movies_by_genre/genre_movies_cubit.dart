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
  int selectGenre = -1;

  void getGenreMovies(int? idGenre) async {print(idGenre);
    //الشرط الاول من اجل اذا اخترنا نفس الفئة ما يتم طلبه من جديد
    // والشرط الثاني من اجل اذا كان هناك خطاء وما تم جاب البيانات يتم جلبها ولو كانت من نفس الفئة
    if (await networkInformation.isConnected) {

      if (selectGenre != idGenre || movies.isEmpty) {
        movies.clear();
        numberPage = 2;
        selectGenre = idGenre!;
        if (movies.isEmpty) {
          emit(GenreMoviesLoading());
        }
        try {
          movies.addAll(await genreMoviesRepository.getGenreMovies(1, idGenre!));
          emit(GenreMoviesSuccess());
        } catch (e) {
          if (movies.isEmpty) {
            emit(GenreMoviesFailure(isNoGenre: false));
          }
        }
      }
    } else {
      movies.clear();
      selectGenre = idGenre!;
      emit(GenreMoviesNotConnected());
    }
  }

  void getFailure() {

    emit(GenreMoviesFailure(isNoGenre: true));

  }

  void getSameGenreMovies() async {
    try {
      movies.addAll(
          await genreMoviesRepository.getGenreMovies(numberPage, selectGenre));
      emit(GenreMoviesSuccess());
      numberPage += 1;
    } catch (e) {
      print('object');
    }
  }
}
