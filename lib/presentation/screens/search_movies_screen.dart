import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/search_movies/search_movie_cubit.dart';
import '../../business_logic/cubit/search_movies/search_movie_state.dart';
import '../../data/models/movie.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_off_the_internet.dart';
import '../widgets/sreach_movies/app_bar_search_widget.dart';
import '../widgets/sreach_movies/grid_view_shimmer_widget.dart';

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
          //getMovie();
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
          }
        }, builder: (context, state) {
          if (state is SearchMovieInitialState) {
            return EmptyWidget(
              icon: Icons.search,
              title: "Enter the movie name...",
            );
          } else if (state is SearchMovieLoading) {
            return GridViewWidget(scrollController: scrollController,isShimmer: true,);
          } else if (state is SearchMovieSuccess) {
            movies = BlocProvider.of<SearchMovieCubit>(context).movies;
            return Column(
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
                    ? SizedBox()
                    : Container(
                        height: 30,
                      )
              ],
            );
          } else {
            return const ImageOffTheInternet();
          }
        }));
  }
}
