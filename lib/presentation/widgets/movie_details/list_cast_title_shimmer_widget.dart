import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/color_manager.dart';
import '../shimmer/shimmer_widget.dart';
class ListCastTitleShimmerWidget extends StatelessWidget {
  const ListCastTitleShimmerWidget({Key? key,required this.index}) : super(key: key);
 final int index;
  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
        width: 150.w,
        height: 10,
        margin: EdgeInsets.only(left: index == 0 ? 0 : 12.w, bottom: 10.h),
        circular: 10,
        color: ColorManager.greyOpacity30);

  }
}
