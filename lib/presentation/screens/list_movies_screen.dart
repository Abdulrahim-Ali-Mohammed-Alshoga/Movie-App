import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_state.dart';
import 'package:movies/presentation/widgets/grid_title_widget.dart';
import 'package:movies/presentation/widgets/sreach_movies/grid_view_shimmer_widget.dart';
import '../../constants/arguments.dart';
import '../../constants/font.dart';
import '../../data/models/movie.dart';

class ListMoviesScreen extends StatefulWidget {
  ListMoviesScreen({Key? key,required this.listMovies}) : super(key: key);
 ListMoviesArgument listMovies;

  @override
  State<ListMoviesScreen> createState() => _ListMoviesScreenState();
}

class _ListMoviesScreenState extends State<ListMoviesScreen> {
  final scrollController = ScrollController();
  late List<Movie> movies;
  bool isLoading = true;
  Future getMovies() async {
    BlocProvider.of<NowPlayingMovieCubit>(context)
        .getAllMovies();
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
   // print(widget.listMovies.genre.id);
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
          title: Text(
            widget.listMovies.name,
           // widget.listMovies.genre.name,
            style: TextStyle(fontFamily: MyFont.titleFont),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<NowPlayingMovieCubit, NowPlayingMovieState>(
          listener: (context, state) {
              isLoading = true;
              print("llllllllllllllllll");
          },
          builder: (context, state) {
            if (state is NowPlayingMovieSuccess ) {
              movies = BlocProvider.of<NowPlayingMovieCubit>(context).movies;
              return
                Column(
                  children: [
                    Expanded(
                      child: Listener(
                          onPointerUp: (v) {
                            if (!isLoading) {
                              scrollController
                                  .jumpTo(scrollController.position.maxScrollExtent);
                            }
                          },
                          child:GridViewWidget(movies: movies,scrollController: scrollController,)
                      ),
                    ),
                    isLoading
                        ? const SizedBox()
                        : Container(
                      height: 30,
                    )
                  ],
                );
            }

            else {
              return Center(
                child: SizedBox(
                  height: .1.h,
                ),
              );
            }
          },
        ));
  }
}
