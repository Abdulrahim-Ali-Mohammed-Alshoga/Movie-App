import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/search_movies_web_service.dart';

class SearchMoviesRepository{

  SearchMoviesWebServices searchMoviesWebServices;
  SearchMoviesRepository(this.searchMoviesWebServices);
  Future<List<Movie>> getSearchMovies({required String name}) async{
    final movies = await searchMoviesWebServices.getSearchMovies(name);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
