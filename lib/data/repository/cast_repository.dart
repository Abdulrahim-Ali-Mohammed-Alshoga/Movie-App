import '../models/cast.dart';
import '../web_services/cast_web_services.dart';

class CastRepository {
  CastWebService castWebService;

  CastRepository(this.castWebService);

  Future<List<Cast>> getCasts(int idMovie) async {
    final casts = await castWebService.getCasts(idMovie);
    return casts.map((cast) => Cast.fromJson(cast)).toList();
  }
}