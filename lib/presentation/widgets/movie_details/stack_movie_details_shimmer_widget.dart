import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/color_manager.dart';
import '../shimmer/shimmer_widget.dart';

class StackMovieDetailsShimmerWidget extends StatelessWidget {
  const StackMovieDetailsShimmerWidget({Key? key}) : super(key: key);

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
          ShimmerWidget(color: ColorManager.greyOpacity30),
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
              top: 280.h,
              bottom: 10,
              child: ShimmerWidget(
                height: 50,
                color: ColorManager.greyOpacity30,
              )),
          Positioned(
            right: 20.w,
            left: 190.w,
            top: 265.h,
            bottom: -120.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 65.h, left: 8.w),
                    child: ShimmerWidget(
                        height: 15,
                        circular: 10,
                        color: ColorManager.greyOpacity30),
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
                        Flexible(
                          child: ShimmerWidget(
                              width: 250,
                              height: 10,
                              circular: 10,
                              color: ColorManager.greyOpacity30),
                        )
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
                        Flexible(
                          child: ShimmerWidget(
                              width: 250,
                              height: 10,
                              circular: 10,
                              color: ColorManager.greyOpacity30),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, left: 8.w),
                    child: Row(
                      children: [  Icon(
                        color: ColorManager.red,
                        Icons.favorite_border,
                        size: 15.r,
                      ),

                        SizedBox(
                          width: 10.w,
                        ),
                        Flexible(
                          child: ShimmerWidget(
                              width: 250,
                              height: 10,
                              circular: 10,
                              color: ColorManager.greyOpacity30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
