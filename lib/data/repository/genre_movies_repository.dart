import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/genre_movies_web_service.dart';

class GenreMoviesRepository {
  GenreMoviesWebService genreMoviesWebService;

  GenreMoviesRepository(this.genreMoviesWebService);

  Future<List<Movie>> getGenreMovies(int numberPage,int genre) async {
    final movies = await genreMoviesWebService.getGenreMovies(numberPage,genre);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
