import 'package:dio/dio.dart';

import '../../constants/conction.dart';

class MovieDetailsWebService{
  late Dio dio;

  MovieDetailsWebService() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 50 * 10000,
        connectTimeout: 50 * 10000);
    dio = Dio(baseOptions);
  }

  Future<dynamic> getMovieDetails(int idMovie) async {
    Response response = await dio.get("movie/$idMovie",
      queryParameters: {"api_key": Conction.apiKye},
    );
print(response.data);
    return response.data;
  }
}