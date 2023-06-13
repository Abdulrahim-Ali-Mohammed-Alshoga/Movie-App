import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/widgets/shimmer/shimmer_widget.dart';

import '../../../../constants/color_manager.dart';

class ListViewWidgetShimmer extends StatelessWidget {
  const ListViewWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: 7,
      itemBuilder: (BuildContext context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 320.w,
              child: Row(
                children: [
                  Stack(

                    children: [
                      ShimmerWidget(
                          color:ColorManager.greyOpacity30,
                          margin: EdgeInsets.only(left: 12.r),
                          height: 150.h,
                          width: 130.w,
                          circular: 20.r),
                      const Positioned(
                        bottom: 5,
                        right: 7,
                        child: Icon(
                            color: ColorManager.red, size: 22, Icons.favorite_border),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 150.h,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: ColorManager.greyOpacity30,
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: ColorManager.greyOpacity30,
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: ColorManager.greyOpacity30,
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: ColorManager.greyOpacity30,
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: ColorManager.greyOpacity30,
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
