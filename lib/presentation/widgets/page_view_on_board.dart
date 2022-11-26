import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/font.dart';

class PageViewOnBoard extends StatelessWidget {
  PageViewOnBoard(
      {Key? key,
      required this.image,
      required this.textOne,
      required this.textTow})
      : super(key: key);
  String image;
  String textOne;
  String textTow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(image),
            height: 300.h,
            width: 300.w,
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            textOne,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.titleFont,
                color: Theme.of(context).textTheme.headline2?.color,
                fontSize: 20.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            textTow,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.mainFont,
                color: Theme.of(context).textTheme.headline2?.color,
                fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}
