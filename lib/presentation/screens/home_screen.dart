import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/genre/genre_cubit.dart';
import 'package:movies/business_logic/cubit/home/home_cubit.dart';
import 'package:movies/business_logic/cubit/home/home_state.dart';
import '../../constants/font.dart';
import '../../constants/color_manager.dart';
import '../widgets/home/genre_movie/list_view_genre_movies_widget.dart';
import '../widgets/home/now_playing_movie/list_view_now_playing_movies_widget.dart';
import '../widgets/home/upcoming_movie/list_view_upcoming_movies_widget.dart';
import '../widgets/image_off_the_internet.dart';
import '../widgets/home/shimmer/home_widget_shimmer.dart';
import '../widgets/show_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool isBackground = false;
  final scrollController = ScrollController();
  bool firstRun = true;
  late ConnectivityResult result = ConnectivityResult.none;
  late ConnectivityResult outResult;

  int lengthListEnd = 1;
  int lengthListStart = 0;

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

    BlocProvider.of<HomeCubit>(context)
        .getAllMovies(mounted: context.mounted, context: context);

    //WidgetsBinding.instance.addObserver(this);
    //  changConnect();
    //   scrollController.addListener(() {
    //
    //     // if(scrollController.offset==scrollController.position.maxScrollExtent){print("lll");
    //     //   setState(() {
    //     //     lengthListStart=lengthListEnd;
    //     //     lengthListEnd+=1;
    //     //   });
    //     // //  getMovies();
    //     // // setState(() {
    //     // //   lengthList+=2;
    //     // // });
    //     // // if(lengthList<=genres.length){
    //     // //
    //     // //   print(lengthList);
    //     // // }
    //     // }
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
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: const HomeWidgetShimmer(),
            );
          }
          if (state is HomeSuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: ScrollConfiguration(

                //وقف لون glow effect اي اللون الذي يظهر عند السحب للاعلى والاسفل في ListView او SingleChildScrollView وغيرها
                behavior:
                    const MaterialScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  //طريقة اخر لوقف لون glow effect اي اللون الذي يظهر عند السحب للاعلى والاسفل في ListView او SingleChildScrollView وغيرها
                 // physics: const BouncingScrollPhysics(),
                controller: scrollController,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 0.w),
                          child: Text(
                            "Now Playing",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: MyFont.titleFont,
                                color:ColorManager.white),
                          ),
                        ),
                      ),
                      // PageViewHomeWidget(
                      //   movies: movies,
                      // ),

                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: ListViewNowPlayingMoviesWidget(),
                      ),

                      ListViewUpcomingMoviesWidget(),
                      const ListViewGenreMoviesWidget(),
                      SizedBox(height: 67.h)
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is HomeNotConnected) {
            return ImageOffTheInternet(
              onPressed: () {
                BlocProvider.of<HomeCubit>(context)
                    .getAllMovies(mounted: mounted, context: context);
              },
            );
          }
          // if (state is GenreInitialState) {
          //   return Center(
          //     child: SizedBox(
          //       height: .1.h,
          //     ),
          //   );
          // }
          else {
            return const SizedBox(
              height: 1,
            );
            // return Center(
            //   child: Padding(
            //     padding: EdgeInsets.only(bottom: 130.h),
            //     child: Image.asset(
            //      ImageAssetName.page_404,
            //       width: 300.w,
            //       height: 400.h,
            //     ),
            //   ),
            // );
          }
        },
      ),
    );
  }
}
