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
  TextEditingController controller= TextEditingController();
  ScrollController scrollController = ScrollController();



  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:  AppBarSearchWidget(controller: controller),
        body: BlocBuilder<SearchMovieCubit, SearchMovieState>(
           builder: (context, state) {
          if (state is SearchMovieInitialState) {
            return EmptyWidget(
              icon: Icons.search,
              title: "Enter the movie name...",
            );
          } else if (state is SearchMovieLoading) {
            return GridViewWidget(scrollController: scrollController,isShimmer: true,);
          } else if (state is SearchMovieSuccess) {
            movies = BlocProvider.of<SearchMovieCubit>(context).movies;
            return
                GridViewWidget(movies: movies,scrollController: scrollController,);

          } else {
            return  ImageOffTheInternet(onPressed: (){
              BlocProvider.of<SearchMovieCubit>(context).getSearchMovie(nameMovie: controller.text);
            },);
          }
        }));
  }
}
