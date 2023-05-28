import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/image_asset_name.dart';
import '../../constants/mycolor.dart';
class ImageOffTheInternet extends StatelessWidget {
   ImageOffTheInternet({Key? key,required this.onPressed}) : super(key: key);
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 130.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
             ImageAssetName.offTheInternet,
              width: 400.w,
              height: 400.h,
            ),
          ),
          const Text('No data connection',style: TextStyle(fontSize: 19,color: Colors.white),),
          TextButton(onPressed:onPressed, child: const Text(
            'Try again',style: TextStyle(color: MyColors.deepOrange),
          ))
        ],
      ),
    );
  }
}
