
import 'package:dio/dio.dart';

import '../../constants/conction.dart';

class UpcomingMoviesWebServices {
  late Dio dio;

  UpcomingMoviesWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 10 * 1000,
        connectTimeout: 10 * 1000);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getUpcomingMovies(dynamic numberPage) async {
    Response response = await dio.get('movie/upcoming',
        queryParameters: {"api_key": Conction.apiKye, "page": numberPage},

    );
    // print(response.data["results"]);
    return response.data["results"];
  }
  // Future<List<dynamic>> getMoviesUpcoming(dynamic numberPage, int genre) async {
  //   Response response = await dio.get("discover/movie",
  //       queryParameters: {"with_genres": genre, "page": numberPage},
  //       options: Options(headers: {
  //         "X-RapidAPI-Key":
  //         "709d1c122fmshfe0fd6fbaca18f5p110cdcjsnbf924af9b188",
  //         "X-RapidAPI-Host": "advanced-movie-search.p.rapidapi.com",
  //         "useQueryString": "true"
  //       }));
  //   //  print(response.data["results"]);
  //
  //   return response.data["results"];
  // }
}