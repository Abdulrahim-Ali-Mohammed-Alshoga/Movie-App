import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/genre_movies_cubit.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/genre_movies_state.dart';
import '../../constants/arguments.dart';
import '../../constants/font.dart';
import '../../data/models/movie.dart';
import '../widgets/failure_widget.dart';
import '../widgets/image_off_the_internet.dart';
import '../widgets/select_container_widgte.dart';
import '../widgets/sreach_movies/grid_view_shimmer_widget.dart';

class ListGenreMoviesScreen extends StatefulWidget {
  ListGenreMoviesScreen({Key? key, required this.listGenreMovies})
      : super(key: key);
  ListGenreMoviesArgument listGenreMovies;

  @override
  State<ListGenreMoviesScreen> createState() => _ListGenreMoviesScreenState();
}

class _ListGenreMoviesScreenState extends State<ListGenreMoviesScreen> {
  final scrollController = ScrollController();
  late List<Movie> movies;
  bool isLoading = true;

  Future getMovies() async {
    BlocProvider.of<GenreMoviesCubit>(context).getSameGenreMovies();
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
            widget.listGenreMovies.namePage,
            // widget.listMovies.genre.name,
            style: const TextStyle(fontFamily: MyFont.titleFont),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SelectContainerWidget(),
            Expanded(
                child: BlocConsumer<GenreMoviesCubit, GenreMoviesState>(
              listener: (context, state) {
                isLoading = true;
              },
              builder: (context, state) {
                if (state is GenreMoviesSuccess) {
                  movies = BlocProvider.of<GenreMoviesCubit>(context).movies;
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
                } else if (state is GenreMoviesLoading) {
                  return GridViewWidget(
                    scrollController: scrollController,
                    isShimmer: true,
                  );
                } else if (state is GenreMoviesNotConnected) {
                  int idGenres =
                      BlocProvider.of<GenreMoviesCubit>(context).selectGenre;

                  return ImageOffTheInternet(
                    onPressed: () {
                      BlocProvider.of<GenreMoviesCubit>(context)
                          .getGenreMovies(idGenres == 0 ? 0 : idGenres);
                    },
                  );
                } else {
                  return FailureWidget(
                    onPressed: () {
                      BlocProvider.of<GenreMoviesCubit>(context).getGenreMovies(
                          BlocProvider.of<GenreMoviesCubit>(context)
                              .selectGenre);
                    },
                    sizeIcon: 50.r,
                  );
                }
              },
            ))
          ],
        ));
  }
}
