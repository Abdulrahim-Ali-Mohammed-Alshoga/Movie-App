class Genre{
   String? name;
  int? id;
  Genre.fromJson(Map<String,dynamic> json){
    name = json['name'];
    id = json['id'];
    //genres = json['genres'];
  }
   Genre.toJson(
       {
         required this.name,
         required this.id,
        });
}