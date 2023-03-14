import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/widgets/shimmer/home/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/font.dart';
import '../../../../constants/mycolor.dart';

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
                  ShimmerWidget(
                      color: Colors.grey.withOpacity(.3),
                      margin: EdgeInsets.only(left: 12.r),
                      height: 150.h,
                      width: 130.w,
                      circular: 20.r),
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
                            color: Colors.grey.withOpacity(.3),
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: Colors.grey.withOpacity(.3),
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: Colors.grey.withOpacity(.3),
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: Colors.grey.withOpacity(.3),
                            margin: EdgeInsets.only(left: 10.w, top: 18.h),
                          ),
                          ShimmerWidget(
                            circular: 4,
                            height: 10,
                            color: Colors.grey.withOpacity(.3),
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
