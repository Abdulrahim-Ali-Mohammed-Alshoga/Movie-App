import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/trending/trending_cubit.dart';
import 'package:movies/business_logic/cubit/trending/trending_state.dart';

import '../../constants/font.dart';
import '../../data/models/movie.dart';
import '../widgets/image_off_the_internet.dart';
import '../widgets/sreach_movies/grid_view_shimmer_widget.dart';
class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {

  final scrollController = ScrollController();
  late List<Movie> movies;
  bool isLoading = true;

  Future getMovies() async {
    BlocProvider.of<TrendingMovieCubit>(context).getTrendingMovie();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (isLoading) {
          getMovies();
          setState(() {
            isLoading = false;
          });
          Timer(const Duration(microseconds: 500), () {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
        }
      } else if (!isLoading) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Trending',
            // widget.listMovies.genre.name,
            style: TextStyle(fontFamily: MyFont.titleFont),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<TrendingMovieCubit, TrendingMovieState>(
          listener: (context, state) {
            isLoading = true;
          },
          builder: (context, state) {
            if (state is TrendingMovieLoading) {
            return GridViewWidget(scrollController: scrollController,isShimmer: true,);
            }
            else   if (state is TrendingMovieSuccess) {
              movies = BlocProvider.of<TrendingMovieCubit>(context).movies;
              return Column(
                children: [
                  Expanded(
                    child: Listener(
                        onPointerUp: (v) {
                          if (!isLoading) {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          }
                        },
                        child: GridViewWidget(
                          movies: movies,
                          scrollController: scrollController,
                        )),
                  ),
                  isLoading
                      ? const SizedBox()
                      : Container(
                    height: 30,
                  )
                ],
              );
            } else {

            return  ImageOffTheInternet(onPressed: (){
            getMovies();
            },);

            }
          },
        ));
  }
}


