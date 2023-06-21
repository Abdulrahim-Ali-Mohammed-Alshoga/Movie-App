import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/cast.dart';
import 'list_cast_title_shimmer_widget.dart';
import 'list_cast_title_widget.dart';

class ListViewCastWidget extends StatelessWidget {
  const ListViewCastWidget({Key? key, this.casts, required this.isShimmer})
      : super(key: key);
  final List<Cast>? casts;
  final bool isShimmer;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 265.h,
        margin: EdgeInsets.only(bottom: 15.h),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: isShimmer ?  casts!.length: 5,
            itemBuilder: (BuildContext context, index) {
              if (isShimmer) {
                return ListCastTitleWidget(
                  cast: casts![index],
                  index: index,
                );
              } else {
                return  ListCastTitleShimmerWidget(
                  index:index,
                );
              }
            }));
  }
}
