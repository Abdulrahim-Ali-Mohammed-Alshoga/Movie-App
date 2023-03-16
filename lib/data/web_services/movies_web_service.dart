import 'package:dio/dio.dart';
import 'package:movies/constants/conction.dart';

class MoviesWebService{
  late Dio dio;

  MoviesWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 10 * 1000,
        connectTimeout: 10 * 1000);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getMovies(dynamic numberPage, int genre) async {
    Response response = await dio.get("discover/movie",
        queryParameters: {"with_genres": genre, "page": numberPage},
        options: Options(headers: {
          "X-RapidAPI-Key":
              "709d1c122fmshfe0fd6fbaca18f5p110cdcjsnbf924af9b188",
          "X-RapidAPI-Host": "advanced-movie-search.p.rapidapi.com",
          "useQueryString": "true"
        }));
    //  print(response.data["results"]);

    return response.data["results"];
  }
}
