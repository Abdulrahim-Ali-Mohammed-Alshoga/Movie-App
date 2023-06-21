import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/genre/genre_cubit.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/genre_movies_cubit.dart';
import 'package:movies/business_logic/cubit/movies_by_genre/genre_movies_state.dart';
import '../../../../constants/arguments.dart';
import '../../../../constants/color_manager.dart';
import '../../../../constants/font.dart';
import '../../../../constants/image_asset_name.dart';
import '../../../../constants/screen_name.dart';
import '../../../../data/models/movie.dart';
import '../../failure_widget.dart';
import '../../list_movie_title_widget.dart';
import '../../select_container_widgte.dart';
import '../shimmer/list_view_widget_shimmer.dart';

class ListViewGenreMoviesWidget extends StatefulWidget {
  const ListViewGenreMoviesWidget({Key? key}) : super(key: key);

  @override
  State<ListViewGenreMoviesWidget> createState() =>
      _ListViewGenreMoviesWidgetState();
}

class _ListViewGenreMoviesWidgetState extends State<ListViewGenreMoviesWidget> {
  late List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Movie ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: MyFont.titleFont,
                        color: ColorManager.white),
                  ),
                  SizedBox(
                    width: 17.w,
                  ),
                ],
              ),
              GestureDetector(
                  onTap: () {
                    if (movies.isNotEmpty) {
                      Navigator.pushNamed(
                              context, ScreenName.listGenreMoviesScreen,
                              arguments: ListGenreMoviesArgument(
                                  namePage: 'Movies', numberSelect: 1))
                          .then((value) => BlocProvider.of<GenreCubit>(context)
                              .startGenre());
                    }
                    // Navigator.pushNamed(context, ScreenName.listMoviesScreen,
                    //     arguments: ListMovies(movies[ind],
                    //         genres[ind], movieCubit[ind]));
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    color: ColorManager.white,
                    size: 27,
                  ))
            ],
          ),
        ),
        const SelectContainerWidget(),
        Container(
            height: 180,
            margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                color: ColorManager.greyOpacity22),
            child: BlocBuilder<GenreMoviesCubit, GenreMoviesState>(
              builder: (context, state) {
                if (state is GenreMoviesFailure) {
                  return FailureWidget(
                    onPressed: () {
                      if (state.isNoGenre) {
                        BlocProvider.of<GenreCubit>(context).getAllGenre();
                      } else {
                        BlocProvider.of<GenreMoviesCubit>(context)
                            .getGenreMovies(
                                BlocProvider.of<GenreMoviesCubit>(context)
                                    .selectGenre);
                      }
                    },
                    sizeIcon: 35.r,
                  );
                } else if (state is GenreMoviesSuccess) {
                  movies = BlocProvider.of<GenreMoviesCubit>(context).movies;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: movies.length > 7 ? 7 : movies.length,
                    itemBuilder: (BuildContext context, index) {
                      var isLastMovie =
                          index == (movies.length > 7 ? 7 : movies.length) - 1
                              ? true
                              : false;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListMovieTitleWidget(
                            movie: movies[index],
                          ),
                          isLastMovie
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                            ScreenName.listGenreMoviesScreen,
                                            arguments: ListGenreMoviesArgument(
                                                namePage: 'Movies',
                                                numberSelect: 1))
                                        .then((value) =>
                                            BlocProvider.of<GenreCubit>(context)
                                                .startGenre());
                                    // Navigator.pushNamed(
                                    //     context, ScreenName.listMoviesScreen,
                                    //     arguments: ListMovies(
                                    //         movies[ind],
                                    //         genres[ind],
                                    //         movieCubit[ind]));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    height: 56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorManager.white
                                              .withOpacity(.5),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(28),
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
                } else {
                  return const ListViewWidgetShimmer();
                }
              },
            )),
      ],
    );
  }
}
// BlocConsumer<GenreCubit, GenreState>(
// builder: (context, state) {
// genres = BlocProvider.of<GenreCubit>(context).genre;
//
// return DropdownButtonHideUnderline(
//
// child: DropdownButton<Genre>(
// iconEnabledColor: ColorManager.deepOrange,
// value: select ?? genres[0],
// alignment: Alignment.centerLeft,
// dropdownColor: ColorManager.black,
//
// items: genres
//     .map((e) => DropdownMenuItem(
//
// value: e,
// child: Text(
// e.name!,
// style: TextStyle(
// fontSize: 16.sp,
// fontFamily: MyFont.titleFont,
// color: ColorManager.deepOrange),
// )))
//     .toList(),
// onChanged: (selected) {
// setState(() {
// select = selected;
// BlocProvider.of<GenreMoviesCubit>(context)
//     .getGenreMovies(selected!.name == 'All'
// ? 0
//     : selected.id);
// });
// }),
// );
// },
// listener: (context, state) {
// if (state is GenreSuccess) {
// BlocProvider.of<GenreMoviesCubit>(context)
//     .getGenreMovies(0);
// }
// },
// ),
