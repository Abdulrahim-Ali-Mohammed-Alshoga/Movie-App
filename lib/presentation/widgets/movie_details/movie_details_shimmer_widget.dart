import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/widgets/movie_details/stack_movie_details_shimmer_widget.dart';

import '../../../constants/color_manager.dart';
import '../../../constants/font.dart';
import '../shimmer/shimmer_widget.dart';
class MovieDetailsShimmerWidget extends StatelessWidget {
  const MovieDetailsShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StackMovieDetailsShimmerWidget(),
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

                SizedBox(
                  width: 5.w,
                ),
              ShimmerWidget(width: 200.w,height: 10,circular: 10,color:  ColorManager.greyOpacity30),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15, left: 20),
              child:Row(
                children: [
                  Text(
                    "Votes : ",
                    style: TextStyle(
                        color: ColorManager.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp),
                  ),
                  ShimmerWidget(width: 212,height: 10,circular: 10,color:  ColorManager.greyOpacity30),
                ],
              )

              ),
          Padding(
              padding: const EdgeInsets.only(top: 15, left: 20),
              child:Row(
                children: [
                  Text(
                    "Genres : ",
                    style: TextStyle(
                        color: ColorManager.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp),
                  ),
                  ShimmerWidget(width: 212,height: 10,circular: 10,color:  ColorManager.greyOpacity30),
                ],
              )

          ),
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
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child:Column(
              children:List.generate(6, (index) => Column(children: [
                SizedBox(height: 10.h),
                ShimmerWidget(
                    height: 11,
                    circular: 10,
                    color: ColorManager.greyOpacity30),
              ],)),
            ) )
        ],
      ),
    );
  }
}
