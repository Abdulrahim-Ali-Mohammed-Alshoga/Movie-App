import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies/business_logic/cubit/auth_state.dart';
import 'package:movies/constants/hive_name.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(AuthInitialState());
  late bool isAuth;
  var box = Hive.box(authDb);


  getAuth() {
    if (box.get(authTable) == null || box.get(authTable) == false) {
      isAuth = false;
      emit(AuthFailure());
    }
    else {
      isAuth = true;
      emit(AuthSuccess());
    }
  }
}