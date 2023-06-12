
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/models/movie.dart';

class ListMoviesArgument{
  //final List<Movie> movies;
  final String  namePage;
  ListMoviesArgument({required this.namePage});
}
class ListGenreMoviesArgument{
  //final List<Movie> movies;
  final String  namePage;
  final int  numberSelect;
  ListGenreMoviesArgument({required this.namePage,required this.numberSelect});
}
class DetailsMovieArgument{
 final Movie detailsMovie;

 DetailsMovieArgument({required this.detailsMovie});
}
class NavigationBarArgument{
  final  bool isSkip;

  NavigationBarArgument({required this.isSkip});
}