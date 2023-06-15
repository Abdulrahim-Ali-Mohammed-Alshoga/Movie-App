import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  String? image;
  @HiveField(1)
  num? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  num? rating;
  @HiveField(4)
  String? productionData;
  @HiveField(5)
  String? description;

  Movie({
    required this.image,
    required this.id,
    required this.title,
    required this.rating,
    required this.productionData,
    this.description,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    image = json['poster_path'];
    id = json['id'];
    title = json['title'];
    rating = json['vote_average'];
    productionData = json['release_date'];
    description = json['overview'];
  }
}
