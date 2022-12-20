
import 'package:movies/data/models/movie.dart';

class ListMovies{
  final List<Movie> movies;
  final String genre;
  ListMovies(this.movies,this.genre);
}
class DetailsMovie{
 final Movie detailsMovie;

 DetailsMovie(this.detailsMovie);
}