import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/color_manager.dart';
import '../../constants/arguments.dart';
import '../../constants/screen_name.dart';
import '../../data/models/hive/movie_hive.dart';
import '../../data/models/movie.dart';
import 'cached_network_image_widget.dart';
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
        Navigator.pushNamed(context, ScreenName.detailsMovieScreen,
            arguments: DetailsMovieArgument(detailsMovie: Movie(image:image ,id:id ,productionData:productionData ,rating: rating)));
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
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: ColorManager.blackOpacity70,
                              offset: Offset(0.0, 14.0),
                              blurRadius: 30,
                              spreadRadius: 15),
                        ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconFavoriteButtonWidget(
                                paddingSize: 0,
                                size: 15,
                                movieHive: MovieHive(
                                    image: image,
                                    id: id,
                                    rating: rating!,
                                    productionData: productionData),
                              ),
                              Text(
                                double.parse("$rating").toStringAsFixed(1),
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  color: ColorManager.whiteOpacity80,
                                ),
                              ),
                              const Icon(Icons.star,
                                  color: ColorManager.whiteOpacity80, size: 9),
                              Expanded(
                                child: Text(
                                  productionData == null || productionData == ""
                                      ? "0000"
                                      : productionData!.substring(0, 4),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.whiteOpacity80,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: CachedNetworkImageWidget(
                        image: image,
                      )
                      // CachedNetworkImage(
                      //   memCacheHeight: 600,
                      //
                      //   // imageBuilder: (context, imageProvider) => Container(
                      //   // decoration: BoxDecoration(
                      //   // image: DecorationImage(
                      //   // image: imageProvider,
                      //   // fit: BoxFit.cover,
                      //   // colorFilter:
                      //   // ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                      //   // ),),
                      //   maxHeightDiskCache: 600,
                      //   imageUrl: image == null
                      //       ? "لل"
                      //       : ImageNetworkName.rootImages + image!,
                      //   cacheKey: image,
                      //   fit: BoxFit.fill,
                      //   errorWidget: (context, url, error) {
                      //     print(error);
                      //     if (error.toString() ==
                      //         "Failed host lookup: 'image.tmdb.org'") {
                      //       return Center(
                      //           child: Icon(
                      //         Icons.wifi_off,
                      //         size: 30.sp,
                      //         color: MyColors.deepOrange,
                      //       ));
                      //     }
                      //     return Center(
                      //       child: Icon(
                      //         Icons.image_not_supported,
                      //         size: 30.sp,
                      //       ),
                      //     );
                      //   },
                      //   placeholder: (context, url) {
                      //     return const Center(
                      //       child: CircularProgressIndicator(
                      //           color: MyColors.deepOrange),
                      //     );
                      //   },
                      // )),
                      )),
            )),
      ),
    );
  }
}
