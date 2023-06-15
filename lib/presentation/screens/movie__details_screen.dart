import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/color_manager.dart';
import 'package:movies/data/models/cast.dart';
import 'package:movies/data/models/genre.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/movie_details/stack_details_moive_widget.dart';
import '../../business_logic/cubit/movie_details/movie_details_cubit.dart';
import '../../business_logic/cubit/movie_details/movie_details_state.dart';
import '../../constants/font.dart';
import '../../data/models/movie_details.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_off_the_internet.dart';
import '../widgets/movie_details/list_view_cast_widget.dart';
import '../widgets/movie_details/movie_details_shimmer_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({Key? key, required this.detailsMovie}) : super(key: key);
  Movie detailsMovie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Movie movie;
  late MovieDetails movieDetails;
  late List<Cast> casts;
  late List<Genre> genres;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<MovieDetailsCubit>(context)
        .getMovieDetails(idMovie: widget.detailsMovie.id!.toInt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    movie = widget.detailsMovie;
    return Scaffold(body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsInitialState) {
            return EmptyWidget(
              icon: Icons.search,
              title: "Enter the movie name...",
            );
          } else if (state is MovieDetailsLoading) {
            return const MovieDetailsShimmerWidget();
          }
          // else if (state is MovieDetailsLoading) {
          //   return GridViewWidget(scrollController: scrollController,isShimmer: true,);
          // }
          else if (state is MovieDetailsSuccess) {
            movieDetails =
            BlocProvider
                .of<MovieDetailsCubit>(context)
                .movieDetails!;
            casts = BlocProvider
                .of<MovieDetailsCubit>(context)
                .casts;
            genres=movieDetails.genres!.cast();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StackDetailsMovieWidget(
                      movie: movie, movieDetails: movieDetails),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 20),
                    child: Row(
                      children: [
                        Text(
                          "Rating : ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: ColorManager.white,
                              fontFamily: MyFont.titleFont,
                              fontSize: 15.sp),
                        ),
                        RatingBarIndicator(
                          rating: movie.rating! / 2,
                          itemBuilder: (context, index) =>
                          const Icon(
                            Icons.star,
                            color: ColorManager.amber,
                          ),
                          itemPadding: const EdgeInsets.only(bottom: 0),
                          itemCount: 5,
                          itemSize: 20.0,
                          unratedColor: ColorManager.grey,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: movie.rating.toString(),
                              style: TextStyle(
                                  color: ColorManager.grey,
                                  fontFamily: MyFont.mainFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp),
                            ),
                            TextSpan(
                              text: "/10",
                              style: TextStyle(
                                  color: ColorManager.grey,
                                  fontSize: 16.sp,
                                  fontFamily: MyFont.mainFont),
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: "Votes : ",
                            style: TextStyle(
                                color: ColorManager.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp),
                          ),
                          TextSpan(
                            text: "${movieDetails.vote} vote",
                            style: TextStyle(
                                color: ColorManager.grey,
                                fontSize: 18.sp,
                                fontFamily: MyFont.mainFont),
                          )
                        ]),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: RichText(maxLines: 1,
                        text: TextSpan(

                            children: <TextSpan>[
                        TextSpan(
                        text: "Genres : ",
                          style: TextStyle(
                              color: ColorManager.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp),
                        ),
                        TextSpan(
                            text: List.generate(
                             genres.length>3?3:genres.length, (
                                index) => genres[index].name).toList().join(' - '),
                              style: TextStyle(
                                  color: ColorManager.grey,
                                  fontSize: 18.sp,
                                  fontFamily: MyFont.mainFont),
                            )
                            ]),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 20.w),
                    child: Text(
                      "Story line :",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: ColorManager.white,
                          fontFamily: MyFont.titleFont,
                          fontSize: 15.sp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20),
                    child: SelectableText(
                      movieDetails.description!,
                      style: TextStyle(
                          color: ColorManager.grey,
                          fontSize: 15.sp,
                          fontFamily: MyFont.mainFont),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 20.w),
                    child: Text(
                      "Cast :",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: ColorManager.white,
                          fontFamily: MyFont.titleFont,
                          fontSize: 15.sp),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 15.h, left: 20.w),
                      child: ListViewCastWidget(casts: casts)
                  ),
                ],
              ),
            );
          } else {
            return ImageOffTheInternet(
              onPressed: () {
                BlocProvider.of<MovieDetailsCubit>(context)
                    .getMovieDetails(idMovie: movie.id!.toInt());
              },
            );
          }
        }));
  }
}
