import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies/business_logic/cubit/auth_state.dart';
import 'package:movies/constants/hive_name.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(AuthSuccess());
  bool typeAuth=false;
  var box = Hive.box(AuthHiveDB.authDB);

// changAuth(){
//   box.put(AuthHiveDB.authTable, true);
//
// }
// changTypeUserAuth(bool type){
//   typeAuth=type;
//   box.put(AuthHiveDB.typeAuthTable, type);
// }
//   getAuth() {
//
//     if (box.get(AuthHiveDB.authTable) == null || box.get(AuthHiveDB.authTable) == false) {
//       emit(AuthFailure());
//     }
//     else {
//
//       emit(AuthSuccess());
//     }
//     if (box.get(AuthHiveDB.typeAuthTable) == null || box.get(AuthHiveDB.typeAuthTable) == false) {
//      typeAuth=false;
//     }
//     else {
//       typeAuth=true;
//     }
//   // box.put(authTable, false);
//   }
}