import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/font.dart';
import '../../../constants/mycolor.dart';
class TextWidgetHome extends StatelessWidget {
   TextWidgetHome({Key? key,required this.text}) : super(key: key);
String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16.sp,
          fontFamily: MyFont.titleFont,
          color: MyColors.white),
    );
  }
}
