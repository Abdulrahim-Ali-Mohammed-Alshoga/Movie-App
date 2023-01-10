class Genre{
  late String name;
  dynamic id;
  Genre.fromJson(Map<String,dynamic> json){
    name = json['name'];
    id = json['id'];

    //genres = json['genres'];
  }
}