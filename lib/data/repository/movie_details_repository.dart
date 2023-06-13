import 'package:movies/data/models/genre.dart';
import '../models/movie_details.dart';
import '../web_services/genre_web_service.dart';
import '../web_services/movie_details_web service.dart';
class MovieDetailsRepository {
  MovieDetailsWebService movieDetailsWebService;

  MovieDetailsRepository(this.movieDetailsWebService);

  Future<MovieDetails> getMovieDetails(int idMovie) async {
    final movieDetails = await movieDetailsWebService.getMovieDetails(idMovie);
    return  MovieDetails.fromJson(movieDetails);
  }
}
