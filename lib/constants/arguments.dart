
import 'package:movies/data/models/genre.dart';
import 'package:movies/data/models/movie.dart';

import '../business_logic/cubit/movies_by_genre/movie_cubit.dart';

class ListMoviesArgument{
  final List<Movie> movies;
  final Genre  genre;
  final MoviesByGenreCubit movieCubit;
  ListMoviesArgument({required this.movies, required this.genre, required this.movieCubit});
}
class DetailsMovieArgument{
 final Movie detailsMovie;

 DetailsMovieArgument({required this.detailsMovie});
}
class NavigationBarArgument{
  final  bool isSkip;

  NavigationBarArgument({required this.isSkip});
}