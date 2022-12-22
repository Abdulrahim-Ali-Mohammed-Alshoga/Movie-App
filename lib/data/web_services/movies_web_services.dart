import 'package:dio/dio.dart';
import 'package:movies/constants/conction.dart';

class MoviesWebServices {
  late Dio dio;

  MoviesWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 10 * 1000,
        connectTimeout: 10 * 1000);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getMovies(int numberPage) async {
    try {
      Response response = await dio.get("discover/movie",queryParameters: {"with_genres":"History","page":numberPage},
          options: Options(headers: {
            "X-RapidAPI-Key":
                "36f399abf4msh3a16281da9a619cp1dc23ejsn0eb027021543",
            "X-RapidAPI-Host": "advanced-movie-search.p.rapidapi.com",
            "useQueryString": "true"
          }));
    //  print(response.data["results"]);

      return response.data["results"];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
