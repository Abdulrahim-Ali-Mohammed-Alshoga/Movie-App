import 'package:dio/dio.dart';
import 'package:movies/constants/conction.dart';

class GenreMoviesWebService{
  late Dio dio;

  GenreMoviesWebService() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 10 * 1000,
        connectTimeout: 10 * 1000);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getGenreMovies(int numberPage, int genre) async {
    Response response = await dio.get("discover/movie",
        queryParameters: {"api_key": Conction.apiKye, "page": numberPage,"with_genres":genre==0?'all':genre});
     //print(response.data["results"]);

    return response.data["results"];
  }
}
