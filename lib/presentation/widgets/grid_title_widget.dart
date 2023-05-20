import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/data/models/movie.dart';

import '../../constants/arguments.dart';
import '../../constants/font.dart';
import '../../constants/image_network_name.dart';
import '../../constants/mycolor.dart';
import '../../constants/screen_name.dart';
import '../../data/models/hive/movie_hive.dart';
import 'icon_favorite_button_widget.dart';

class GridTitleWidget extends StatelessWidget {
  num id;
  num? rating;
  String? productionData;
  String? image;


  GridTitleWidget(
      {Key? key,

      required this.productionData,
      required this.id,
      required this.rating,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, ScreenName.detailsMovieScreen,
        //     arguments: DetailsMovieArgument( detailsMovie: movie));
      },
      child: Hero(
        tag: id,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10).r),
            child: Padding(
              padding: const EdgeInsets.all(1).w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10).r,
                child: GridTile(
                    footer: Container(
                      height: 25.h,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black54.withOpacity(.62),
                            offset: const Offset(0.0, 14.0),
                            blurRadius: 30,
                            spreadRadius: 15),
                      ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconFavoriteButtonWidget(paddingSize: 0,size: 15,movieHive:  MovieHive(
                                image:image,
                                id: id,
                                rating: rating!,
                                productionData:
                               productionData),),
                            Text(
                              double.parse("$rating").toStringAsFixed(1),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                                color: Colors.white.withOpacity(.8),
                              ),
                            ),
                           Icon(Icons.star,
                                  color: Colors.white.withOpacity(.8), size: 9),

                            Expanded(
                              child: Text(
                                productionData == null || productionData == ""
                                    ? "0000"
                                    : productionData!.substring(0, 4),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: CachedNetworkImage(
                      memCacheHeight: 600,

                      // imageBuilder: (context, imageProvider) => Container(
                      // decoration: BoxDecoration(
                      // image: DecorationImage(
                      // image: imageProvider,
                      // fit: BoxFit.cover,
                      // colorFilter:
                      // ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                      // ),),
                      maxHeightDiskCache: 600,
                      imageUrl: image == null
                          ? "لل"
                          : ImageNetworkName.rootImages + image!,
                      cacheKey: image,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) {
                        print(error);
                        if (error.toString() ==
                            "Failed host lookup: 'image.tmdb.org'") {
                          return Center(
                              child: Icon(
                            Icons.wifi_off,
                            size: 30.sp,
                            color: MyColors.deepOrange,
                          ));
                        }
                        return Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 30.sp,
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: MyColors.deepOrange),
                        );
                      },
                    )),
              ),
            )),
      ),
    );
  }
}
