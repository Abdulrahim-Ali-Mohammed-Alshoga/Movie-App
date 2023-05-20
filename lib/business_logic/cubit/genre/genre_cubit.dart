import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/genre/genre_state.dart';
import 'package:movies/data/models/genre.dart';
import 'package:movies/data/repository/genre_repository.dart';

class GenreCubit extends Cubit<GenreState>{
  GenreCubit(this.genreRepository):super(GenreInitialState());
  GenreRepository genreRepository;
  List<Genre> genre = [Genre.toJson(name: "All", id: 0)];

  Future<void> getAllGenre() async {
      if (genre.isEmpty) {
        emit(GenreLoading());
      }
      try {
        genre.addAll(await genreRepository.getGenre());
        emit(GenreSuccess());

      } catch (e) {
        print(e);
        emit(GenreFailure());
      }

    }

}