import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/cast.dart';
import '../../../data/repository/cast_repository.dart';
import 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  CastCubit(this.castRepository) : super(CastInitialState());
  CastRepository castRepository;
  int numberSelectGenre = 0;
  List<Cast> cast = [];
  Future<void> getAllCast({required int idMovie}) async {
    try {
      cast.addAll(await castRepository.getCasts(idMovie));
      emit(CastSuccess());
    } catch (e) {
      print(e);
    }
  }
}