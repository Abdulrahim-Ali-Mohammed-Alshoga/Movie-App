import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/app/extensions.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/cached_network_image_widget.dart';
import '../../../business_logic/cubit/favorite/favorite_cubit.dart';
import '../../../constants/font.dart';
import '../../../constants/color_manager.dart';
import '../../../data/models/movie_details.dart';
import '../icon_favorite_button_widget.dart';
import '../show/image_show.dart';

class StackDetailsMovieWidget extends StatefulWidget {
  const StackDetailsMovieWidget(
      {Key? key, required this.movie, required this.movieDetails})
      : super(key: key);
  final Movie movie;
  final MovieDetails movieDetails;

  @override
  State<StackDetailsMovieWidget> createState() =>
      _StackDetailsMovieWidgetState();
}

class _StackDetailsMovieWidgetState extends State<StackDetailsMovieWidget> {
  late bool isFavorite;
@override
  void initState() {
    // TODO: implement initState
   isFavorite =
          BlocProvider.of<FavoriteCubit>(context).isMovieFavorite(widget.movie.id!);
    super.initState();
  }
  String changeTime(int time) {
    int minutes;
    double hours;
    minutes = time % 60;

    hours = time / 60;
    print(time);
    return '${hours.floor()} h $minutes m';
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 475.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorManager.black,
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 100.h),
            child: CachedNetworkImageWidget(
              image: widget.movieDetails.imageBackdrop.orEmpty,
              colorIcon: ColorManager.white,
            ),
          ),
          Container(
            color: ColorManager.blackOpacity20,
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 290.h,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: ColorManager.black,
                    blurRadius: 55,
                    spreadRadius: 55,
                    offset: Offset(0.0, 30.0.h))
              ]),
            ),
          ),
          Positioned(
            right: 240.w,
            left: 20.w,
            top: 260.h,
            bottom: 10,
            child: GestureDetector(
              onTap: () {
                myImageShow(
                    image: widget.movie.image!, id: widget.movie.id, context: context);
              },
              child: Hero(
                tag: widget.movie.id!,
                child: Container(
                  color: ColorManager.black,
                  child: CachedNetworkImageWidget(
                    image: widget.movie.image.orEmpty,
                    colorIcon: ColorManager.whiteOpacity80,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            left: 190.w,
            top: 250.h,
            bottom: -120.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 65.h, left: 8.w),
                    child: AutoSizeText(widget.movie.title!,
                        maxLines: 2,
                        style: TextStyle(
                            color: ColorManager.white,
                            fontSize: 20.sp,
                            fontFamily: MyFont.titleFont)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 8.w),
                    child: Row(
                      children: [
                        Icon(Icons.event,
                            color: ColorManager.grey, size: 15.sp),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(widget.movie.productionData!.orEmptyData,
                            style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: 15.sp,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, left: 8.w),
                    child: Row(
                      children: [
                        Icon(Icons.timer, color: ColorManager.grey, size: 15.w),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(changeTime(widget.movieDetails.time!.toInt()),
                            style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: 15.sp,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, left: 3.w),
                    child: Row(
                      children: [
                        IconFavoriteButtonWidget(
                          returnFavorite: (isFavorite){
                            setState(() {
                              this.isFavorite=isFavorite;
                            });
                          },
                            movieHive: widget.movie, paddingSize: 0, size: 15),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(isFavorite ? 'Your favorite' : 'Add to favorite',
                            style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: 15.sp,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //     height: 105.h,
          //     width: 55.w,
          //     child: IconFavoriteButtonWidget(
          //         movieHive: widget.movie, paddingSize: 10, size: 25)),
        ],
      ),
    );
  }
}
