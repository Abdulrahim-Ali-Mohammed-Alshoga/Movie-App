import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/image_asset_name.dart';
class ImageOffTheInternet extends StatelessWidget {
  const ImageOffTheInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 130.h),
        child: Image.asset(
         ImageAssetName.offTheInternet,
          width: 400.w,
          height: 400.h,
        ),
      ),
    );
  }
}
