import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import '../../../../business_logic/cubit/now_playing_movies/now_playing_movies_state.dart';
import '../../../../constants/arguments.dart';
import '../../../../constants/color_manager.dart';
import '../../../../constants/font.dart';
import '../../../../constants/image_asset_name.dart';
import '../../../../constants/screen_name.dart';
import '../../../../data/models/movie.dart';
import '../../failure_widget.dart';
import '../../page_view_home_widget.dart';
import '../shimmer/list_view_widget_shimmer.dart';
import '../shimmer/page_view_widget_shimmer.dart';

class ListViewNowPlayingMoviesWidget extends StatelessWidget {
  ListViewNowPlayingMoviesWidget({Key? key}) : super(key: key);
  late List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {

          return Column(
            children: [
              SizedBox(
                height: 430.h,
                child: BlocBuilder<NowPlayingMovieCubit, NowPlayingMovieState>(
                  builder: (context, state) {
                    if (state is NowPlayingMovieLoading ||
                        state is NowPlayingMovieInitialState) {
                      return const PageViewWidgetShimmer();
                    }
                    if (state is NowPlayingMovieSuccess) {
                      movies =
                          BlocProvider.of<NowPlayingMovieCubit>(context).movies;
                      return PageViewHomeWidget(
                        movies: movies.toList(),
                      );
                    }
                    else {
                      return FailureWidget(onPressed: (){ BlocProvider.of<NowPlayingMovieCubit>(context)
                          .getAllMovies();},sizeIcon: 40.h,);
                    }
                  },
                ),
              ),
            ],
          );

  }
}
