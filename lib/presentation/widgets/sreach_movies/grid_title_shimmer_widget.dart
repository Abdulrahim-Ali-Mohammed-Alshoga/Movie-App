import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/color_manager.dart';
import '../shimmer_widget.dart';
class GridTitleShimmerWidget extends StatelessWidget {
  const GridTitleShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
        child: ShimmerWidget(
          circular: 10,
            color: ColorManager.greyOpacity30),
      ),
    );

  }
}
