import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../constants/hive_name.dart';
import '../../../data/models/movie.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState>{
  FavoriteCubit():super(FavoriteInitialState());
   List<Movie> movieFavorites=[];
  var box = Hive.box<Movie>(MovieFavoriteHiveDB.movieDB);

 getMovieFavorite() {
  if(box.toMap().values.toList().isNotEmpty){
    movieFavorites = box.values.toList();
    emit(FavoriteSuccess());
  }
}
  Future addMovieFavorite(Movie movieHive) async{
    movieFavorites.add(movieHive);
    await box.add(movieHive);
    emit(FavoriteAdd());
  }
 Future removeMovieFavorite(Movie movieHive) async{
    for (int i = 0; i < movieFavorites.length; i++) {
      if (movieFavorites[i].id == movieHive.id) {

        movieFavorites.removeAt(i);
        await box.deleteAt(i);
        if(movieFavorites.isNotEmpty){
          emit(FavoriteSuccess());
        }
       else{
          emit(FavoriteInitialState());
        }
      }
    }}
  bool isMovieFavorite(num id) {
    return movieFavorites.where((item) => item.id == id).isNotEmpty;
  }
  }