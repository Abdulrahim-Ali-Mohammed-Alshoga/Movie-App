import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/movies_web_services.dart';

import '../web_services/genre_web_services.dart';
import '../web_services/genre_web_services.dart';

class GenreRepository {
  GenreWebServices genreWebServices;

  GenreRepository(this.genreWebServices);

  Future<List<Movie>> getMovies() async {
    final movies = await genreWebServices.getGenre();
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
