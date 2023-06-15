import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/color_manager.dart';
import '../../../data/models/cast.dart';
import 'list_cast_title_widget.dart';

class ListViewCastWidget extends StatelessWidget {
  ListViewCastWidget({Key? key, required this.casts}) : super(key: key);
  List<Cast> casts;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 265.h,
        margin: EdgeInsets.only(bottom: 15.h),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: casts.length,
            itemBuilder: (BuildContext context, index) {
              return ListCastTitleWidget(
                cast: casts[index],
                index: index,
              );
            }));
  }
}
