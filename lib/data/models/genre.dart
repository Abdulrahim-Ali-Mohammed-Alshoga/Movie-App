class Genre{
  late String name;
  late int id;
  Genre.fromJson(Map<String,dynamic> json){
    name = json['name'];
    id = json['id'];

    //genres = json['genres'];
  }
}