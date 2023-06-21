import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/app/extensions.dart';
import 'package:movies/data/models/cast.dart';

import '../../../constants/color_manager.dart';
import '../../../constants/font.dart';
import '../../../constants/image_asset_name.dart';
import '../cached_network_image_widget.dart';

class ListCastTitleWidget extends StatelessWidget {
  const ListCastTitleWidget({Key? key, required this.index, required this.cast})
      : super(key: key);
 final Cast cast;
 final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(left: index == 0 ? 0 : 12.w, bottom: 10.h),
      decoration: BoxDecoration(
          color: ColorManager.greyOpacity22,
          boxShadow: const [
            CustomBoxShadow(
                blurRadius: 2,
                offset: Offset(0, 1),
                color: ColorManager.black,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer
                // inset: isPressed,
                ),
            CustomBoxShadow(
              blurRadius: 6,
              offset: Offset(0, 1),
              color: ColorManager.blackDark,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              // inset: isPressed,
            ),
          ],
          borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r)),
            child: cast.image.orEmpty.isEmpty
                ? Center(
                    child: Image.asset(
                        height: 180.h, width: 120.w, ImageAssetName.user),
                  )
                : CachedNetworkImageWidget(
                    image: cast.image!,
                    height: 180.h,
                    width: 150.w,
                  ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h ,horizontal: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(cast.name!.orEmpty,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: MyFont.titleFont,
                          color: ColorManager.white)),
                  Text(cast.characterName!.orEmpty,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;

  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    double spreadRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
  }) : super(
            color: color,
            offset: offset,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}
