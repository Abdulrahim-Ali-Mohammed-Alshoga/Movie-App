import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/business_logic/cubit/genre_state.dart';
import 'package:movies/data/models/genre.dart';
import 'package:movies/data/repository/genre_repository.dart';

class GenreCubit extends Cubit<GenreState>{
  GenreCubit(this.genreRepository):super(GenreInitialState());
  GenreRepository genreRepository;
  List<Genre> genre = [];


  void getAllGenre() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
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
    } else {
      if (genre.isEmpty) {
        emit(GenreNotConnected());
      }
    }
  }
}