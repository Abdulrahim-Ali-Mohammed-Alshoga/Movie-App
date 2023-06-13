import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/screen_name.dart';
import 'package:movies/data/models/movie.dart';
import '../../constants/arguments.dart';
import '../../constants/color_manager.dart';
import '../../data/models/hive/movie_hive.dart';
import 'cached_network_image_widget.dart';
import 'icon_favorite_button_widget.dart';
class ListMovieTitleWidget extends StatelessWidget {
   ListMovieTitleWidget({Key? key,required this.movie}) : super(key: key);
Movie movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Navigator.pushNamed(context, ScreenName.detailsMovieScreen,arguments: DetailsMovieArgument(detailsMovie: movie));
      },
      child: SizedBox(
        width: 320.w,
        child: Row(
          children: [
            Container(
              height: 150.h,
              margin: EdgeInsets.only(left: 12.r),
              width: 130.w,
              decoration: BoxDecoration(
                  color: ColorManager.greyOpacity20,
                  borderRadius: BorderRadius.circular(20.r)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImageWidget(image: movie.image!),
                    Positioned.fill(
                      bottom: 5,
                    right: 7,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconFavoriteButtonWidget(paddingSize: 0,size: 22,movieHive:  MovieHive(
                            image:movie.image,
                            id: movie.id!,
                            rating: movie.rating!,
                            productionData:
                            movie.productionData),),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SizedBox(height: 150.h,
                child: Padding(
                  padding:  EdgeInsets.only(left: 10.w,top: 8.h),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(movie.title!,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16.sp, fontFamily: MyFont.titleFont,color: ColorManager.white)
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 4.h),
                        child: RatingBarIndicator(
                          rating:movie.rating!/2,unratedColor: ColorManager.grey,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: ColorManager.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                      ),
                      Flexible(
                        child:Text(movie.description!,
                          maxLines: 4,

                     overflow:TextOverflow.ellipsis ,
                          style: const TextStyle(
fontSize: 12,
                              fontWeight: FontWeight.bold,
                             color: ColorManager.grey
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
