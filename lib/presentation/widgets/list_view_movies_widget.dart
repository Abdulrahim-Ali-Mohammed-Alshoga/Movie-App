import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/genre_movies_state.dart';
import 'package:movies/constants/image_asset_name.dart';
import 'package:movies/presentation/widgets/page_view_home_widget.dart';
import 'package:movies/presentation/widgets/home/shimmer/list_view_widget_shimmer.dart';
import 'package:movies/presentation/widgets/home/shimmer/page_view_widget_shimmer.dart';
import '../../business_logic/cubit/movies_by_genre/genre_movies_cubit.dart';
import '../../constants/color_manager.dart';
import '../../constants/font.dart';
import '../../data/models/genre.dart';
import '../../data/models/movie.dart';
import 'list_movie_title_widget.dart';
class ListViewMoviesWidget extends StatefulWidget {
  List<Genre> genres;
  int start;
  int end;
   ListViewMoviesWidget({Key? key,required this.genres,required this.start,required this.end}) : super(key: key);

  @override
  State<ListViewMoviesWidget> createState() => _ListViewMoviesWidgetState();
}

class _ListViewMoviesWidgetState extends State<ListViewMoviesWidget> {

  late List<List<Movie>> movies = [];
 late List<Genre> genres=[];

  late List<GenreMoviesCubit> movieCubit = [];

  Future getMovies(BuildContext context, int index) async {
    Timer(Duration(seconds: 3 * index), () {
      //   BlocProvider.of<MovieCubit>(context).getAllMovies(genres[1].id);
      print(4555);
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

genres=widget.genres;
  }
  @override
  Widget build(BuildContext context) {
    // for(int i=widget.start;i<widget.end;i++){
    //   genres.add(widget.genres[i]);
    // }
    // movies=[];movieCubit = [];

    return ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, ind) {
         // movieCubit.add(GenreMoviesCubit(GenreMoviesRepository(GenreMoviesWebService())));
          return BlocProvider.value(
            value: movieCubit[ind]..getGenreMovies(genres[ind].id),
            child: Column(
              children: [
                ind==0?
                SizedBox(
                  height: 430.h,
                  child: BlocBuilder<GenreMoviesCubit, GenreMoviesState>(
                    builder: (context, state) {
                      if (state is GenreMoviesLoading) {
                        return const PageViewWidgetShimmer();
                      }
                      if (state is GenreMoviesSuccess ) {
                       movies.add(BlocProvider.of<GenreMoviesCubit>(context).movies);
                        return PageViewHomeWidget(
                          movies: movies[ind].reversed.toList(),
                        );
                      }


                       else {
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
                ):const SizedBox(),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        genres[ind].name!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: MyFont.titleFont,
                            color: ColorManager.white),
                      ),
                      GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, ScreenName.listMoviesScreen,
                            //     arguments: ListMoviesArgument(movies: movies[ind],
                            //       genre:   genres[ind], movieCubit: movieCubit[ind]));
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            color: ColorManager.white,
                            size: 27,
                          ))
                    ],
                  ),
                ),
                Container(
                    height: 180,
                    margin: EdgeInsets.only(top: 10.h,bottom: 15.h),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: ColorManager.greyOpacity22),
                    child: BlocBuilder<GenreMoviesCubit,GenreMoviesState>(
                      builder: (context, state) {
                        if (state is GenreMoviesLoading) {
                          return const ListViewWidgetShimmer();
                        }
                        if (state is GenreMoviesSuccess) {
                          if(ind>0){
                            movies
                                .add(BlocProvider.of<GenreMoviesCubit>(context).movies);
                          }


                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                            movies[ind].length > 7 ? 7 : movies[ind].length,
                            itemBuilder: (BuildContext context, index) {
                              var isLastMovie = index ==
                                  (movies[ind].length > 7
                                      ? 7
                                      : movies[ind].length) -
                                      1
                                  ? true
                                  : false;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListMovieTitleWidget(
                                    movie: movies[ind][index],
                                  ),
                                  isLastMovie
                                      ? GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     // context, ScreenName.listMoviesScreen,
                                      //     // arguments: ListMoviesArgument(
                                      //     //  movies:    movies[ind],
                                      //     //   genre:   genres[ind],
                                      //     //     movieCubit:  movieCubit[ind])
                                      // );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorManager.white
                                                .withOpacity(.5),
                                            width: 1),
                                        borderRadius:
                                        BorderRadius.circular(28),
                                      ),
                                      child: const Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: ColorManager.white,
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

                       else {
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
            ),
          );
        });
  }
}


