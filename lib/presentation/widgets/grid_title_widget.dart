import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/app/extensions.dart';
import 'package:movies/constants/color_manager.dart';
import '../../constants/arguments.dart';
import '../../constants/screen_name.dart';
import '../../data/models/movie.dart';
import 'cached_network_image_widget.dart';
import 'icon_favorite_button_widget.dart';

class GridTitleWidget extends StatelessWidget {
  Movie movie;

  GridTitleWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ScreenName.detailsMovieScreen,
            arguments: DetailsMovieArgument(detailsMovie: movie));
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10).r),
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
                              movieHive: movie,
                            ),
                            Text(
                              double.parse("${movie.rating}")
                                  .toStringAsFixed(1),
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
                                movie.productionData!.orEmptyData
                                    .substring(0, 4),
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
                      image: movie.image.orEmpty,
                    ))),
          )),
    );
  }
}
