import 'package:movies/data/models/movie.dart';
import '../web_services/upcoming_movies_web_service.dart';

class UpcomingMoviesRepository {
  UpcomingMoviesWebServices upcomingMoviesWebServices;

  UpcomingMoviesRepository(this.upcomingMoviesWebServices);

  Future<List<Movie>> getUpcomingMovies(dynamic numberPage) async {
    final movies = await upcomingMoviesWebServices.getUpcomingMovies(numberPage);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}