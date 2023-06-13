import 'package:movies/data/models/genre.dart';

class MovieDetails {

  String? imageBackdrop;
  num? vote;
  late String? title;
  String? language;
  num? time;
  String? productionData;
  List<dynamic>? genres;
  String? description;

  //late List<dynamic> genres;
  MovieDetails.fromJson(Map<String, dynamic> json) {
    imageBackdrop = json['backdrop_path'];
    // imageBackdrop = json['backdrop_path'];
    genres = json['genres'].map((genre) => Genre.fromJson(genre))
        .toList();
    vote = json['vote_average'];
    time = json['runtime'];
    language = json['original_language'];
    // watch = json['popularity'];
    description = json['overview'];
    //genres = json['genres'];
  }
}
