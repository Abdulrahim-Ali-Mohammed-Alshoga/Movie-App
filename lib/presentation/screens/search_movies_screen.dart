import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business_logic/cubit/search_movie_cubit.dart';
import '../../business_logic/cubit/search_movie_state.dart';
import '../../constants/font.dart';
import '../../constants/mycolor.dart';
import '../../data/models/movie.dart';
import '../widgets/sreach_movies/app_bar_search_widget.dart';
import '../widgets/grid_title_widget.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({Key? key}) : super(key: key);

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  late List<Movie> movies;

  ScrollController scrollController = ScrollController();

  getMovie() {
    BlocProvider.of<SearchMovieCubit>(context).numberPage += 1;

    BlocProvider.of<SearchMovieCubit>(context).getSearchMovie();
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (isLoading) {
          getMovie();
          setState((){isLoading = false;});
Timer(Duration(microseconds: 10), () {scrollController.jumpTo(scrollController.position.maxScrollExtent) ;});
print(44);
        }
      }
    });
    super.initState();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBarSearchWidget(),
        body: BlocConsumer<SearchMovieCubit, SearchMovieState>(
            listener: (context, state) {
          if (state is SearchMovieSuccess) {
            isLoading = true;
            print(544444444444);
          }
        }, builder: (context, state) {
          if (state is SearchMovieInitialState) {
            movies = BlocProvider.of<SearchMovieCubit>(context).movies;
            return Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: MyColors.white,
                      size: 37,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Enter the movie name...",
                      style: TextStyle(
                          fontFamily: MyFont.titleFont,
                          color: MyColors.white,
                          fontSize: 22.sp),
                    )
                  ]),
            );
          } else if (state is SearchMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.deepOrange,
              ),
            );
          } else if (state is SearchMovieSuccess) {
            movies = BlocProvider.of<SearchMovieCubit>(context).movies;
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    cacheExtent: 100,
                    shrinkWrap: true,
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, index) {
// if(index+1==movies.length){
//
//   isLoading=true;
//   print(5555555555);
// }
                      return GridTitleWidget(
                        movie: movies[index],
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .8,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1),
                  ),
                ),
isLoading?SizedBox():Container(
  height: 30,

)
              ],
            );
          } else {
            return Center(
              child: SizedBox(
                height: .1.h,
              ),
            );
          }
        }));
  }
}
