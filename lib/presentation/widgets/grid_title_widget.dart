import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/data/models/movie.dart';

import '../../constants/arguments.dart';
import '../../constants/font.dart';
import '../../constants/mycolor.dart';
import '../../constants/name_page.dart';

class GridTitleWidget extends StatelessWidget {
  GridTitleWidget({Key? key, required this.movie}) : super(key: key);
  Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, detailsMovieScreen,arguments: DetailsMovie(movie));
      },
      child: Hero(
        tag: movie.id,
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

                      decoration:
                  BoxDecoration(
                        boxShadow:[
                          BoxShadow(
                          color: Colors.black54.withOpacity(.62),
                          offset: Offset(0.0,14.0),
                          blurRadius: 30,
                          spreadRadius: 15
                        ),

                        ]
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: const Icon(
                                  color: Colors.white,
                                  size: 15,
                                  Icons.favorite),
                            ),
                            Text(
                              movie.rating.toString(),
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
                                movie.productionData.substring(0, 4),
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
                      memCacheHeight: 400,
                      maxHeightDiskCache: 400,
                      imageUrl: movie.image,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) {
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
