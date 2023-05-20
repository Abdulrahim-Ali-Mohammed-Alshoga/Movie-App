import 'package:hive/hive.dart';
part 'movie_hive.g.dart';
@HiveType(typeId: 0)
class MovieHive extends HiveObject {
  @HiveField(0)
  num id;
  @HiveField(1)
  String? image;
  @HiveField(2)
  num rating;
  @HiveField(3)
  late String? productionData;

  MovieHive(
      {
      required this.image,
      required this.id,
      required this.rating,
      required this.productionData});
// flutter packages pub run build_runner build
}
