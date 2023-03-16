import 'package:movies/data/models/genre.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/movies_web_service.dart';

import '../web_services/genre_web_service.dart';
import '../web_services/genre_web_service.dart';

class GenreRepository {
  GenreWebService genreWebServices;

  GenreRepository(this.genreWebServices);

  Future<List<Genre>> getGenre() async {
    final genre = await genreWebServices.getGenre();
    return genre.map((movie) => Genre.fromJson(movie)).toList();
  }
}
