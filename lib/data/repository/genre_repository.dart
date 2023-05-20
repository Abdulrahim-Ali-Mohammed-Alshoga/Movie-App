import 'package:movies/data/models/genre.dart';
import '../web_services/genre_web_service.dart';
class GenreRepository {
  GenreWebService genreWebServices;

  GenreRepository(this.genreWebServices);

  Future<List<Genre>> getGenre() async {
    final genres = await genreWebServices.getGenre();
    return genres.map((genre) => Genre.fromJson(genre)).toList();
  }
}
