import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/color_manager.dart';
import '../../constants/font.dart';
class EmptyWidget extends StatelessWidget {
   EmptyWidget({Key? key,required this.icon,required this.title}) : super(key: key);
IconData icon;
String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              icon,
              color: ColorManager.white,
              size: 37,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: MyFont.titleFont,
                  color: ColorManager.white,
                  fontSize: 22.sp),
            )
          ]),
    );
  }
}
