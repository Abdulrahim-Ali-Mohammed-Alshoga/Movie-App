import '../models/movie.dart';
import '../web_services/trending_movies_web_service.dart';

class TrendingMoviesRepository {
  TrendingMoviesWebService trendingMoviesWebService;

  TrendingMoviesRepository(this.trendingMoviesWebService);

  Future<List<Movie>> getTrendingMovies({required int numberPage}) async {
    final movies = await trendingMoviesWebService.getTrendingMovies(numberPage);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}