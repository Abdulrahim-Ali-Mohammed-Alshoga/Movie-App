
import 'package:movies/data/models/genre.dart';
import 'package:movies/data/models/movie.dart';

import '../business_logic/cubit/movie_cubit.dart';

class ListMovies{
  final List<Movie> movies;
  final Genre  genre;
  final MovieCubit movieCubit;
  ListMovies(this.movies,this.genre,this.movieCubit);
}
class DetailsMovie{
 final Movie detailsMovie;

 DetailsMovie(this.detailsMovie);
}