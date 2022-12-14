import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/genre_cubit.dart';
import 'package:movies/business_logic/cubit/movie_state.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/constants/name_page.dart';
import 'package:movies/data/repository/movies_repository.dart';
import 'package:movies/data/web_services/movies_web_services.dart';
import 'package:movies/presentation/widgets/page_view_home_widget.dart';

import '../../business_logic/cubit/movie_cubit.dart';
import '../../constants/arguments.dart';
import '../../constants/font.dart';
import '../../data/models/genre.dart';
import '../../data/models/movie.dart';
import '../../data/repository/genre_repository.dart';
import '../../data/web_services/genre_web_services.dart';
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

  late List<MovieCubit> movieCubit = [];

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

        itemCount: 3,
        shrinkWrap: true,

        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, ind) {
          print(ind);
          print("tttttttttt");
          movieCubit.add(MovieCubit(MoviesRepository(MoviesWebServices())));
          return BlocProvider.value(
            value: movieCubit[ind]..getAllMovies(genres[ind].id, ind * 3),
            child: Column(
              children: [
                ind==0?
                SizedBox(
                  height: 430.h,
                  child: BlocBuilder<MovieCubit, MovieState>(
                    builder: (context, state) {
                      if (state is MovieLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: MyColors.deepOrange,
                          ),
                        );
                      }
                      if (state is MovieSuccess) {
                       movies.add(BlocProvider.of<MovieCubit>(context).movies);
                        return PageViewHomeWidget(
                          movies: movies[ind].reversed.toList(),
                        );
                      }
                      if (state is NotConnected) {
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
                      if (state is MovieInitialState) {
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
                ):SizedBox(),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        genres[ind].name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: MyFont.titleFont,
                            color: MyColors.white),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, listMoviesScreen,
                                arguments: ListMovies(movies[ind],
                                    genres[ind], movieCubit[ind]));
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
                    margin: EdgeInsets.only(top: 10.h,bottom: 15.h),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Colors.grey.withOpacity(.22)),
                    child: BlocBuilder<MovieCubit, MovieState>(
                      builder: (context, state) {
                        if (state is MovieLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: MyColors.deepOrange,
                            ),
                          );
                        }
                        if (state is MovieSuccess) {
                          if(ind>0){
                            movies
                                .add(BlocProvider.of<MovieCubit>(context).movies);
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
                                      Navigator.pushNamed(
                                          context, listMoviesScreen,
                                          arguments: ListMovies(
                                              movies[ind],
                                              genres[ind],
                                              movieCubit[ind]));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyColors.white
                                                .withOpacity(.5),
                                            width: 1),
                                        borderRadius:
                                        BorderRadius.circular(28),
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
                        if (state is NotConnected) {
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
                        if (state is MovieInitialState) {
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
                    )),
              ],
            ),
          );
        });
  }
}


