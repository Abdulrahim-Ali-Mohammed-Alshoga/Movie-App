class Cast{
  String? name;
  String? characterName;
  String? image;
  Cast.fromJson(Map<String,dynamic> json){
    name = json['name'];
    characterName = json['character'];
    image = json['profile_path'];
    //genres = json['genres'];
  }

}