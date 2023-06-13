
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/color_manager.dart';
import 'package:movies/presentation/widgets/cached_network_image_widget.dart';

  Future<void> myImageShow({required BuildContext context, required String image,required id}){
    double minScale=1;
    double maxScale=3;
    return  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      barrierDismissible: true,
      reverseTransitionDuration: const Duration(milliseconds: 50),
      transitionDuration: const Duration(milliseconds: 500),
      barrierColor: ColorManager.blackOpacity45
      ,
      pageBuilder: (context, _, __) {
        return Hero(
            tag: id,
            child: Align(
              alignment: Alignment.center,
              child: InteractiveViewer(
                clipBehavior: Clip.none,
               // panEnabled: false,
                maxScale:maxScale ,
                minScale: minScale,
                child: CachedNetworkImageWidget(
                 image: image,
                  height: 350.h,
                  width: 250.w,
                ),
              ),
            ));
      },
    ));
    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: true, // user must tap button!
    //   builder: (BuildContext context) {
    //     return Hero(tag: id, child: Center(
    //       child: CachedNetworkImage(
    //         imageUrl:image,
    //         height: 350,
    //         width: 250,
    //         key: UniqueKey(),
    //         fit: BoxFit.fill,
    //         cacheKey:image,
    //         memCacheHeight: 600,
    //         maxHeightDiskCache: 600,
    //       ),
    //     ));
    //   },
    // );

  }
