import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/movie_cubit.dart';
import 'package:movies/presentation/widgets/app_bar_widget.dart';

import '../../constants/font.dart';
import '../../constants/mycolor.dart';
import '../widgets/show_snack_bar.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      BlocProvider.of<MovieCubit>(context).getAllActors(context);
      print(result.index);
      ShowSnackBarWidget.checkInternetConnectivity(context,result.index,);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(nameAppBar: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "Cinema",
              style: TextStyle(fontFamily: MyFont.mainFont,color: MyColors.white,fontSize: 30.sp)
            ),
            TextSpan(
                text: "Batool",
                style: TextStyle(fontFamily: MyFont.mainFont,color: MyColors.deepOrange,fontSize: 30.sp)
            ),
          ]
        ),
      )),
    );
  }
}
