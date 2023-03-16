import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/search_movies_web_services.dart';

class SearchMoviesRepository{

  SearchMoviesWebServices searchMoviesWebServices;
  SearchMoviesRepository(this.searchMoviesWebServices);
  Future<List<Movie>> getSearchMovies({required String name, required int numberPage}) async{
    final movies = await searchMoviesWebServices.getSearchMovies(name, numberPage);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
