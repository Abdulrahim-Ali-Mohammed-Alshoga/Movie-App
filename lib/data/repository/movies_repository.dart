import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/movies_web_services.dart';

class MoviesRepository {
  MoviesWebServices moviesWebServices;

  MoviesRepository(this.moviesWebServices);

  Future<List<Movie>> getMovies(dynamic numberPage,int genre) async {
    final movies = await moviesWebServices.getMovies(numberPage,genre);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
