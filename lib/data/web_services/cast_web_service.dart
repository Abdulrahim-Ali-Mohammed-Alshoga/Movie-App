import 'package:dio/dio.dart';

import '../../constants/conction.dart';

class CastWebService{
  late Dio dio;

  CastWebService() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 10 * 1000,
        connectTimeout: 10 * 1000);
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getCasts(int idMovie) async {
    Response response = await dio.get("movie/$idMovie/credits",
        queryParameters: {"api_key": Conction.apiKye});
   // print(response.data["results"]);

    return response.data["cast"];
  }
}