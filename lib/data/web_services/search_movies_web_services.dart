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

  Future<List<dynamic>> getSearchMovies(String name, int numberPage) async {
    Response response = await dio.get("search/movie",
        queryParameters: {"query": name, "page": numberPage},
        options: Options(headers: {
         // 2a4a97c563mshfb277159c4c4a00p102c47jsnc724b435ad6a
          "X-RapidAPI-Key":
              "709d1c122fmshfe0fd6fbaca18f5p110cdcjsnbf924af9b188",
          "X-RapidAPI-Host": "advanced-movie-search.p.rapidapi.com",
          "useQueryString": "true"
        }));
    //  print(response.data["results"]);

    return response.data["results"];
  }
}
