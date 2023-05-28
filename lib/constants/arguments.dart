
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/models/movie.dart';

class ListMoviesArgument{
  //final List<Movie> movies;
  final String  name;
  ListMoviesArgument({required this.name});
}
class DetailsMovieArgument{
 final Movie detailsMovie;

 DetailsMovieArgument({required this.detailsMovie});
}
class NavigationBarArgument{
  final  bool isSkip;

  NavigationBarArgument({required this.isSkip});
}