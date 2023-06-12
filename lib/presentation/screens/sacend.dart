import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/image_asset_name.dart';
import '../../business_logic/cubit/movies_by_genre/genre_movies_cubit.dart';
import '../../business_logic/cubit/movies_by_genre/genre_movies_state.dart';
import '../../constants/font.dart';
import '../../constants/color_manager.dart';
import '../../data/models/movie.dart';
import '../widgets/page_view_home_widget.dart';
import '../widgets/show_snack_bar.dart';

class Secand extends StatefulWidget {
  const Secand({Key? key}) : super(key: key);

  @override
  State<Secand> createState() => _SecandState();
}

class _SecandState extends State<Secand> {
  bool isBackground = false;
  bool firstRun = true;
  late ConnectivityResult result = ConnectivityResult.none;
  late ConnectivityResult outResult;
  late List<Movie> movies;

  initAction() {
    if (!isBackground) {
      ShowSnackBarWidget.checkInternetConnectivity(context, result.index);
    }
  }

  getMovies() {
  //  BlocProvider.of<MovieCubit>(context).getAllMovies();
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

   // BlocProvider.of<MovieCubit>(context).getAllMovies();

    changConnect();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  // // TODO: implement didChangeAppLifecycleState
  // super.didChangeAppLifecycleState(state);
  // if (state == AppLifecycleState.paused) {
  // isBackground = true;
  // outResult = result;
  // } else if (state == AppLifecycleState.resumed) {
  // isBackground = false;
  // var connectivityResult = await (Connectivity().checkConnectivity());
  // if (connectivityResult.index != outResult.index) {
  // result = connectivityResult;
  // initAction();
  // }
  // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarWidget(
      //     nameAppBar: RichText(
      //   text: TextSpan(children: <TextSpan>[
      //     TextSpan(
      //         text: "Cinema",
      //         style: TextStyle(
      //             fontFamily: MyFont.mainFont,
      //             color: MyColors.white,
      //             fontSize: 30.sp)),
      //     TextSpan(
      //         text: "Batool",
      //         style: TextStyle(
      //             fontFamily: MyFont.mainFont,
      //             color: MyColors.deepOrange,
      //             fontSize: 30.sp)),
      //   ]),
      // )),
      body: BlocBuilder<GenreMoviesCubit, GenreMoviesState>(
        builder: (context, state) {
          if (state is GenreMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorManager.deepOrange,
              ),
            );
          }
          if (state is GenreMoviesSuccess) {
            movies = BlocProvider.of<GenreMoviesCubit>(context).movies;
            print("555");
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: SingleChildScrollView(
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
                              color: ColorManager.white),
                        ),
                      ),
                    ),
                    PageViewHomeWidget(
                      movies: movies,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Action",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: MyFont.titleFont,
                                color: ColorManager.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                //Navigator.pushNamed(context, listMoviesScreen,
                                   // arguments: ListMovies(movies, "Action"));
                              },
                              child: const Icon(
                                Icons.keyboard_arrow_right,
                                color: ColorManager.white,
                                size: 27,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                 //     child: ListViewMoviesWidget(movies: movies),
                    )
                  ],
                ),
              ),
            );
          }

          if (state is GenreMoviesInitialState) {
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
                  ImageAssetName.page_404,
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
