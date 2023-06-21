import 'package:movies/data/models/movie.dart';
import 'package:movies/data/web_services/now_playing_movies_web_service.dart';

class NowPlayingMoviesRepository {
  NowPlayingMoviesWebServices nowPlayingMoviesWebServices;

  NowPlayingMoviesRepository(this.nowPlayingMoviesWebServices);

  Future<List<Movie>> getNewPlayingMovies(dynamic numberPage) async {
    final movies = await nowPlayingMoviesWebServices.getNowPlayingMovies(numberPage);
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}