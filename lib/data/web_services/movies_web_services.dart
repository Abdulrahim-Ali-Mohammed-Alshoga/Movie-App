import 'package:dio/dio.dart';
import 'package:movies/constants/conction.dart';

class MoviesWebServices {
  late Dio dio;

  MoviesWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 20 * 1000,
        connectTimeout: 20 * 1000);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getMovies() async {
    try {
      // Response response = await dio.get("movies",
      //     options: Options(headers: {
      //       "X-RapidAPI-Key":
      //           "36f399abf4msh3a16281da9a619cp1dc23ejsn0eb027021543",
      //       "X-RapidAPI-Host": "movies-app1.p.rapidapi.com",
      //       "useQueryString": "true"
      //     }));
      // print(response);

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
