import 'package:dio/dio.dart';
import 'package:movies/constants/conction.dart';

class GenreWebServices {
  late Dio dio;

  GenreWebServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Conction.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout: 50 * 10000,
        connectTimeout: 50 * 10000);
    dio = Dio(baseOptions);
  }

  // 36f399abf4msh3a16281da9a619cp1dc23ejsn0eb027021543
  // 4329affd40msh598eccc1a0d4922p10f9d0jsn736d6ccf8dea
  // 709d1c122fmshfe0fd6fbaca18f5p110cdcjsnbf924af9b188
  Future<List<dynamic>> getGenre() async {
    Response response = await dio.get("genre/movie/list",
        queryParameters: {'api_key': Conction.apiKye},
    );
    //  print(response.data["results"]);
     print(response.data["genres"]);

    return response.data["genres"];
  }
}

// Future<List<dynamic>> getGenre() async {
//   Response response = await dio.get("genre/movie/list",
//       options: Options(headers: {
//         "X-RapidAPI-Key":
//             "709d1c122fmshfe0fd6fbaca18f5p110cdcjsnbf924af9b188",
//         "X-RapidAPI-Host": "advanced-movie-search.p.rapidapi.com",
//         "useQueryString": "true"
//       }));
//   //  print(response.data["results"]);
//
//   return response.data["genres"];
// }
