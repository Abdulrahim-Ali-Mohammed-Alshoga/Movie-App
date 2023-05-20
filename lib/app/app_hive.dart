import 'package:hive_flutter/adapters.dart';
import '../constants/hive_name.dart';
import '../data/models/hive/movie_hive.dart';

class AppHive {
  Future get getInitHive async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieHiveAdapter());
    await Hive.openBox(AuthHiveDB.authDB);
    await Hive.openBox<MovieHive>(MovieFavoriteHiveDB.movieDB);
  }
}
