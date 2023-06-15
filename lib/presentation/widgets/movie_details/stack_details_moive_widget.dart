import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/cached_network_image_widget.dart';
import '../../../constants/font.dart';
import '../../../constants/color_manager.dart';
import '../../../data/models/movie_details.dart';
import '../show/image_show.dart';

class StackDetailsMovieWidget extends StatelessWidget {
  StackDetailsMovieWidget({Key? key, required this.movie,required this.movieDetails}) : super(key: key);
  Movie movie;
  MovieDetails movieDetails;
String changeTime(int time){
  int minutes;
  double hours;
  minutes=time%60;

  hours=time/60 ;
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
          CachedNetworkImageWidget(
            image: movieDetails.imageBackdrop!,
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
                myImageShow(image:movie.image! ,id: movie.id,context: context);
              },
              child: Hero(
                tag: movie.id!,
                child: Container(
                  color: ColorManager.black,
                  child: CachedNetworkImageWidget(
                    image: movie.image,
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
                    child: AutoSizeText(movie.title!,
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
                        Icon(Icons.event, color: ColorManager.grey, size: 15.sp),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(movie.productionData!,
                            style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: 15.sp,
                            )),
                      ],
                    ),
                  ), Padding(
                    padding: EdgeInsets.only(top: 3.h, left: 8.w),
                    child: Row(
                      children: [
                        Icon(Icons.timer,
                            color: ColorManager.grey, size: 15.w),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(changeTime(movieDetails.time!.toInt()),
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
                        Icon(Icons.language, color: ColorManager.grey, size: 15.sp),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(movieDetails.language!,
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
          Positioned(
              height: 110.h,
              width: 70.w,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24.h,
                    color: ColorManager.white,
                  ))),
        ],
      ),
    );
  }
}