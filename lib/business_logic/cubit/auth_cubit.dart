import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies/business_logic/cubit/auth_state.dart';
import 'package:movies/constants/hive_name.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(AuthInitialState());
  bool typeAuth=false;
  var box = Hive.box(authDb);

changAuth(){
  box.put(authTable, true);

}
changTypeAuth(bool type){
  typeAuth=type;
  box.put(typeAuthTable, type);
}
  getAuth() {

    if (box.get(authTable) == null || box.get(authTable) == false) {
      emit(AuthFailure());
    }
    else {

      emit(AuthSuccess());
    }
    if (box.get(typeAuthTable) == null || box.get(typeAuthTable) == false) {
     typeAuth=false;
    }
    else {
      typeAuth=true;
    }
   box.put(authTable, false);
  }
}