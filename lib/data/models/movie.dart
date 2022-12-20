class Movie {
  late String image;
  late String imageBackdrop;
  late int id;
  late int vote;
  late String title;
  late String language;
  late double watch;
  dynamic rating;
  late String productionData;
  late String description;

  //late List<dynamic> genres;
  Movie.fromJson(Map<String, dynamic> json) {
    image = json['poster_path'];
    imageBackdrop = json['backdrop_path'];
    id = json['id'];
    vote = json['vote_count'];
    language = json['original_language'];
    watch = json['popularity'];
    title = json['title'];
    rating = json['vote_average'];
    productionData = json['release_date'];
    description = json['overview'];
    //genres = json['genres'];
  }
}
