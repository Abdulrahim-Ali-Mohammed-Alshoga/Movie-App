import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/name_page.dart';
import 'package:movies/data/models/movie.dart';

import '../../constants/arguments.dart';
import '../../constants/mycolor.dart';
class ListMovieTitleWidget extends StatelessWidget {
   ListMovieTitleWidget({Key? key,required this.movie}) : super(key: key);
Movie movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Navigator.pushNamed(context, detailsMovieScreen,arguments: DetailsMovie(movie));
      },
      child: Container(
        width: 320.w,
        child: Row(
          children: [
            Container(
              height: 150.h,
              margin: EdgeInsets.only(left: 12.r),
              width: 130.w,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(20.r)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CachedNetworkImage(
                  memCacheHeight: 600,
                  maxHeightDiskCache: 600,
                  imageUrl: movie.image,

                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) {
                    if (error.toString() ==
                        "Failed host lookup: 'image.tmdb.org'"
                    )
                    {
                      return  Center(
                          child: Icon(
                            Icons.wifi_off,
                            size: 30.sp,
                            color: MyColors.deepOrange,
                          ));
                    }
                    return  Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 30.sp,
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return const Center(
                      child:  CircularProgressIndicator(
                          color: MyColors.deepOrange
                      ),
                    );},
                ),
              ),
            ),

            Expanded(
              child: SizedBox(height: 140,
                child: Padding(
                  padding:  EdgeInsets.only(left: 10.w),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(movie.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16.sp, fontFamily: MyFont.titleFont,color: MyColors.white)
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 4.h),
                        child: RatingBarIndicator(
                          rating:movie.rating/2,unratedColor: Colors.grey,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                      ),
                      Flexible(
                        child:Text(movie.description,
                          maxLines: 4,

                     overflow:TextOverflow.ellipsis ,
                          style: const TextStyle(
fontSize: 12,
                              fontWeight: FontWeight.bold,
                             color: Colors.grey
                          )
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
