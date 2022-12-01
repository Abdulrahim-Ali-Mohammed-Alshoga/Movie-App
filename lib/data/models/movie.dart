class Movie{
  late String image;
  late String title;
  late String rating;
  late String productionData;
  late String description;
  late List<dynamic> genres;
  Movie.fromJson(Map<String,dynamic> json){
    image = json['image'];
    title = json['titleOriginal'];
    rating = json['rating'];
    productionData = json['release'];
    description = json['description'];
    genres = json['genres'];
  }
}