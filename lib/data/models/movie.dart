class Movie{
  late String image;
  late int id;
  late String title;
  late double rating;
  late String productionData;
  late String description;
  //late List<dynamic> genres;
  Movie.fromJson(Map<String,dynamic> json){
    image = json['poster_path'];
    id = json['id'];
    title = json['title'];
    rating = json['vote_average'];
    productionData = json['release_date'];
    description = json['overview'];
    //genres = json['genres'];
  }
}