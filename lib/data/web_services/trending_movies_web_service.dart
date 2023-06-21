

import 'package:dio/dio.dart';

import '../../constants/conction.dart';

class TrendingMoviesWebService {
  late Dio dio;

  TrendingMoviesWebService() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 10 * 1000,
        connectTimeout: 10 * 1000);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getTrendingMovies(dynamic numberPage) async {
    Response response = await dio.get('trending/movie/week',
      queryParameters: {"api_key": Conction.apiKye, "page": numberPage},

    );
    // print(response.data["results"]);
    return response.data["results"];
  }
}