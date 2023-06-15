import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/widgets/sreach_movies/grid_view_shimmer_widget.dart';
import '../../business_logic/cubit/upcoming_movies/upcoming_movies_cubit.dart';
import '../../business_logic/cubit/upcoming_movies/upcoming_movies_state.dart';
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
    BlocProvider.of<UpcomingMovieCubit>(context)
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
            widget.listMovies.namePage,
           // widget.listMovies.genre.name,
            style: const TextStyle(fontFamily: MyFont.titleFont),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<UpcomingMovieCubit, UpcomingMovieState>(
          listener: (context, state) {
              isLoading = true;
          },
          builder: (context, state) {
            if (state is UpcomingMovieSuccess ) {
              movies = BlocProvider.of<UpcomingMovieCubit>(context).movies;
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
