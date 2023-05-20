
import 'package:dio/dio.dart';

import '../../constants/conction.dart';

class NowPlayingMoviesWebServices {
  late Dio dio;

  NowPlayingMoviesWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 10 * 1000,
        connectTimeout: 10 * 1000);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getNowPlayingMovies(int numberPage) async {
    Response response = await dio.get('movie/now_playing',
      queryParameters: {"api_key": Conction.apiKye, "page": numberPage},

    );
    // print(response.data["results"]);
    return response.data["results"];
  }

}