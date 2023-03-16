import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/movies_web_service.dart';

import '../web_services/upcoming_movies_web_services.dart';

class UpcomingMoviesRepository {
  UpcomingMoviesWebServices upcomingMoviesWebServices;

  UpcomingMoviesRepository(this.upcomingMoviesWebServices);

  Future<List<Movie>> getUpcomingMovies(dynamic numberPage) async {
    final movies = await upcomingMoviesWebServices.getUpcomingMovies(numberPage);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}