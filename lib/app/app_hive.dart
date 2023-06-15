import 'package:hive_flutter/adapters.dart';
import '../constants/hive_name.dart';
import '../data/models/movie.dart';

class AppHive {
  Future get getInitHive async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieAdapter());
    await Hive.openBox(AuthHiveDB.authDB);
    await Hive.openBox<Movie>(MovieFavoriteHiveDB.movieDB);
  }
}
