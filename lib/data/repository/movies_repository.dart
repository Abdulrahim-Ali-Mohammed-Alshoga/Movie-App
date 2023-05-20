import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/movies_by_genre_web_service.dart';

class MoviesByGenreRepository {
  MoviesByGenreWebService moviesByGenreWebService;

  MoviesByGenreRepository(this.moviesByGenreWebService);

  Future<List<Movie>> getMoviesByGenre(int numberPage,int genre) async {
    final movies = await moviesByGenreWebService.getMoviesByGenre(numberPage,genre);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
