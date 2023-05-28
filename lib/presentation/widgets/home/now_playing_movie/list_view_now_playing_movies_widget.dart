import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../business_logic/cubit/now_playing_movies/now_playing_movies_state.dart';
import '../../../../constants/arguments.dart';
import '../../../../constants/font.dart';
import '../../../../constants/image_asset_name.dart';
import '../../../../constants/mycolor.dart';
import '../../../../constants/screen_name.dart';
import '../../../../data/models/movie.dart';
import '../../list_movie_title_widget.dart';
import '../shimmer/list_view_widget_shimmer.dart';

class ListViewNowPlayingMoviesWidget extends StatelessWidget {
  ListViewNowPlayingMoviesWidget({Key? key}) : super(key: key);
  late List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Now Playing",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: MyFont.titleFont,
                    color: MyColors.white),
              ),
              GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, ScreenName.listMoviesScreen,
                    //     arguments: ListMovies(movies[ind],
                    //         genres[ind], movieCubit[ind]));
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.white,
                    size: 27,
                  ))
            ],
          ),
        ),
        Container(
            height: 180,
            margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                color: Colors.grey.withOpacity(.22)),
            child: BlocBuilder<NowPlayingMovieCubit, NowPlayingMovieState>(
              builder: (context, state) {
                if (state is NowPlayingMovieLoading) {
                  return const ListViewWidgetShimmer();
                }
                if (state is NowPlayingMovieSuccess) {
                  movies =
                      BlocProvider.of<NowPlayingMovieCubit>(context).movies;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: movies.length > 7 ? 7 : movies.length,
                    itemBuilder: (BuildContext context, index) {
                      var isLastMovie =
                          index == (movies.length > 7 ? 7 : movies.length) - 1
                              ? true
                              : false;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListMovieTitleWidget(
                            movie: movies[index],
                          ),
                          isLastMovie
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(

                                        context, ScreenName.listMoviesScreen,arguments: ListMoviesArgument(name: "Now playing"));
                                        // arguments: ListMovies(
                                        //     movies[ind],
                                        //     genres[ind],
                                        //     movieCubit[ind]));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    height: 56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColors.white.withOpacity(.5),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: const Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 30,
                                      color: MyColors.white,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0.1.h,
                                )
                        ],
                      );
                    },
                  );
                }

                if (state is NowPlayingMovieInitialState) {
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
            )),
      ],
    );
  }
}
