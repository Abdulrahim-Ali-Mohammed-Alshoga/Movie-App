import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../constants/hive_name.dart';
import '../../../data/models/hive/movie_hive.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState>{
  FavoriteCubit():super(FavoriteInitialState());
   List<MovieHive> movieFavorites=[];
  var box = Hive.box<MovieHive>(MovieFavoriteHiveDB.movieDB);

 getMovieFavorite() {
  if(box.toMap().values.toList().isNotEmpty){
    movieFavorites = box.values.toList();
    emit(FavoriteSuccess());
  }
}
  Future addMovieFavorite(MovieHive movieHive) async{
    movieFavorites.add(movieHive);
    await box.add(movieHive);
    emit(FavoriteAdd());
  }
 Future removeMovieFavorite(MovieHive movieHive) async{
    for (int i = 0; i < movieFavorites.length; i++) {
      if (movieFavorites[i].id == movieHive.id) {

        movieFavorites.removeAt(i);
        await box.deleteAt(i);
        emit(FavoriteSuccess());
      }
    }}
  bool isMovieFavorite(num id) {
    return movieFavorites.where((item) => item.id == id).isNotEmpty;
  }
  }