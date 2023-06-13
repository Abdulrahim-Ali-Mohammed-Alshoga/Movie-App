class Movie {
  String? image;
  num? id;
  String? title;
  num? rating;
  String? productionData;
  String? description;

  Movie(
      {required this.image,
      required this.id,
      required this.rating,
      required this.productionData});

  Movie.fromJson(Map<String, dynamic> json) {
    image = json['poster_path'];
    // imageBackdrop = json['backdrop_path'];
    id = json['id'];
    // vote = json['vote_count'];
    // language = json['original_language'];
    // watch = json['popularity'];
    title = json['title'];
    rating = json['vote_average'];
    productionData = json['release_date'];
    description = json['overview'];
    //genres = json['genres'];
  }
}
