import 'package:movies/data/models/genre.dart';

class MovieDetails {
  String? imageBackdrop;
  num? vote;
  late String? title;
  String? language;
  num? time;
  String? productionData;
  List<Genre>? genres;
  String? description;

  MovieDetails.fromJson(Map<String, dynamic> json) {
    imageBackdrop = json['backdrop_path'];
    genres =
        (json['genres'] as List).map((genre) => Genre.fromJson(genre)).toList();
    vote = json['vote_count'];
    time = json['runtime'];
    language = json['original_language'];
    description = json['overview'];
  }
}
