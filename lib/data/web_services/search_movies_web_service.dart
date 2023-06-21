import 'package:dio/dio.dart';
import 'package:movies/constants/conction.dart';

class SearchMoviesWebServices {
  late Dio dio;

  SearchMoviesWebServices() {
    BaseOptions baseOptions = BaseOptions(
        connectTimeout: 10 * 1000,
        baseUrl: Conction.baseUrl,
        receiveTimeout: 10 * 1000,
        receiveDataWhenStatusError: true);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getSearchMovies(String name) async {
    Response response = await dio.get("search/movie",
        queryParameters: {"api_key": Conction.apiKye,"query": name},
 );
     print(response.data["results"]);

    return response.data["results"];
  }
}
