import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/genre_cubit.dart';
import 'package:movies/business_logic/cubit/movie_cubit.dart';
import 'package:movies/business_logic/cubit/movie_state.dart';
import 'package:movies/constants/name_page.dart';
import 'package:movies/data/models/genre.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/app_bar_widget.dart';
import 'package:movies/presentation/widgets/page_view_home_widget.dart';

import '../../business_logic/cubit/genre_state.dart';
import '../../constants/arguments.dart';
import '../../constants/font.dart';
import '../../constants/mycolor.dart';
import '../widgets/list_view_movies_widget.dart';
import '../widgets/show_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool isBackground = false;
  final scrollController=ScrollController();
  bool firstRun = true;
  late ConnectivityResult result = ConnectivityResult.none;
  late ConnectivityResult outResult;
  late List<Genre> genre;
int lengthListEnd=1;
int lengthListStart=0;
  initAction() {
    if (!isBackground) {
      ShowSnackBarWidget.checkInternetConnectivity(context, result.index);
    }
  }

  getMovies() {
    BlocProvider.of<GenreCubit>(context).getAllGenre();
  }

  changConnect() async {
    if (result.index == 4 && firstRun) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.index == 4) {
        firstRun = false;
      }
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      this.result = result;
      if (!firstRun) {
        getMovies();
        initAction();
      } else {
        firstRun = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
print(566666666666);
    BlocProvider.of<GenreCubit>(context).getAllGenre();
    WidgetsBinding.instance.addObserver(this);
    changConnect();
    scrollController.addListener(() {

      // if(scrollController.offset==scrollController.position.maxScrollExtent){print("lll");
      //   setState(() {
      //     lengthListStart=lengthListEnd;
      //     lengthListEnd+=1;
      //   });
      // //  getMovies();
      // // setState(() {
      // //   lengthList+=2;
      // // });
      // // if(lengthList<=genres.length){
      // //
      // //   print(lengthList);
      // // }
      // }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isBackground = true;
      outResult = result;
    } else if (state == AppLifecycleState.resumed) {
      isBackground = false;
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.index != outResult.index) {
        result = connectivityResult;
        initAction();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          nameAppBar: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Cinema",
              style: TextStyle(
                  fontFamily: MyFont.mainFont,
                  color: MyColors.white,
                  fontSize: 30.sp)),
          TextSpan(
              text: "Batool",
              style: TextStyle(
                  fontFamily: MyFont.mainFont,
                  color: MyColors.deepOrange,
                  fontSize: 30.sp)),
        ]),
      )),
      body: BlocBuilder<GenreCubit, GenreState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.deepOrange,
              ),
            );
          }
          if (state is GenreSuccess) {
            genre = BlocProvider.of<GenreCubit>(context).genre;
            print("555");
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 30.w),
                        child: Text(
                          "Recent Movies",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: MyFont.titleFont,
                              color: MyColors.white),
                        ),
                      ),
                    ),
                    // PageViewHomeWidget(
                    //   movies: movies,
                    // ),

                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: ListViewMoviesWidget(genres: genre,end:lengthListEnd,start: lengthListStart, ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is GenreNotConnected) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 130.h),
                child: Image.asset(
                  "assets/images/Interneton.png",
                  width: 400.w,
                  height: 400.h,
                ),
              ),
            );
          }
          if (state is GenreInitialState) {
            return Center(
              child: SizedBox(
                height: .1.h,
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 130.h),
                child: Image.asset(
                  "assets/images/404Page.png",
                  width: 300.w,
                  height: 400.h,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
