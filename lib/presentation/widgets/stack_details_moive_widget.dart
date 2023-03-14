import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/show/image_shoe.dart';

import '../../constants/font.dart';
import '../../constants/mycolor.dart';

class StackDetailsMovieWidget extends StatelessWidget {
  StackDetailsMovieWidget({Key? key, required this.movie}) : super(key: key);
  Movie movie;
  bool checkImage = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 475.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyColors.black,
      ),
      child: Stack(

        children: [
          CachedNetworkImage(
              imageUrl: movie.imageBackdrop,
              key: UniqueKey(),
              height: 350.h,
              memCacheHeight: 700,
              maxHeightDiskCache: 700,
              errorWidget: (context, url, error) {
                if (error.toString() ==
                    "Failed host lookup: 'image.tmdb.org'") {
                  return Center(
                      child: Icon(
                    Icons.wifi_off,
                    size: 70.sp,
                    color: MyColors.deepOrange,
                  ));
                }
                //   print(error.);

                return Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 70.sp,
                  ),
                );
              },
              placeholder: (context, url) {
                return const Center(
                  child:
                      CircularProgressIndicator(color: MyColors.deepOrange),
                );
              },
              fit: BoxFit.cover),
          Opacity(
            opacity: .5,
            child: Container(
              color: MyColors.black,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 290.h,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: MyColors.black,
                    blurRadius: 55,
                    spreadRadius: 55,
                    offset: Offset(0.0, 30.0.h))
              ]),
            ),
          ),
          Positioned(
            right: 240.w,
            left: 20.w,
            top: 260.h,
bottom: 10,
            child: GestureDetector(
              onTap: () {
                myImageShow(image:movie.image ,id: movie.id,context: context);
              },
              child: Hero(
                tag: movie.id,
                child: Container(
                  color: MyColors.black,
                  child: CachedNetworkImage(
                    imageUrl: movie.image,
                    key: UniqueKey(),
                    fit: BoxFit.fill,
                    cacheKey: movie.image,
                    memCacheHeight: 600,
                    maxHeightDiskCache: 600,
                    errorWidget: (context, url, error) {
                      checkImage = false;
                      if (error.toString() ==
                          "Failed host lookup: 'image.tmdb.org'") {
                        return Center(
                            child: Icon(
                          Icons.wifi_off,
                          size: 70.sp,
                          color: MyColors.deepOrange,
                        ));
                      }
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 70.sp,
                        ),
                      );
                    },
                    placeholder: (context, url) {
                      checkImage = true;
                      return const Center(
                        child: CircularProgressIndicator(
                            color: MyColors.deepOrange),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            left: 190.w,
            top: 250.h,
            bottom: -120.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 65.h, left: 8.w),
                    child: AutoSizeText(movie.title,
                        maxLines: 2,
                        style: TextStyle(
                            color: MyColors.white,
                            fontSize: 20.sp,
                            fontFamily: MyFont.titleFont)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 8.w),
                    child: Row(
                      children: [
                        Icon(Icons.event, color: Colors.grey, size: 15.sp),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(movie.productionData,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, left: 8.w),
                    child: Row(
                      children: [
                        Icon(Icons.language, color: Colors.grey, size: 15.sp),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(movie.language,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, left: 8.w),
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye,
                            color: Colors.grey, size: 15.w),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(movie.watch.toInt().toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              height: 110.h,
              width: 70.w,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24.h,
                    color: MyColors.white,
                  ))),
        ],
      ),
    );
  }
}
