import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movies/business_logic/cubit/favorite/favorite_cubit.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/data/models/movie.dart';

import '../../constants/arguments.dart';
import '../../constants/hive_name.dart';
import '../../constants/image_network_name.dart';
import '../../constants/screen_name.dart';
import '../../data/models/hive/movie_hive.dart';
import 'icon_favorite_button_widget.dart';

class PageViewHomeWidget extends StatefulWidget {
  List<Movie> movies;

  PageViewHomeWidget({Key? key, required this.movies}) : super(key: key);

  @override
  State<PageViewHomeWidget> createState() => _PageViewHomeWidgetState();
}

class _PageViewHomeWidgetState extends State<PageViewHomeWidget> {
  final PageController _pageController = PageController(viewportFraction: .50);
  int _currentPage = 0;
  double width = 180.w;
  var box = Hive.box<MovieHive>(MovieFavoriteHiveDB.movieDB);


  @override
  void initState() {
    // TODO: implement initState
    // double mid=widget.movies.length/2;
    //  _pageController=  PageController(viewportFraction: .50,initialPage:mid.toInt());
    //  _currentPage=mid.toInt();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      itemCount: widget.movies.length > 10 ? 10 : widget.movies.length,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (int page) {
        setState(() {
          _currentPage = page;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        bool active = index == _currentPage;

        final double top = active ? 30.h : 70.h;
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ScreenName.detailsMovieScreen,
                    arguments: DetailsMovieArgument(
                        detailsMovie: widget.movies[index]));
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubicEmphasized,
                margin: EdgeInsets.only(top: top, bottom: 10.h, right: 30.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: const Color(0xfff0f0f0).withOpacity(.3),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20).r,
                        child: CachedNetworkImage(
                            imageUrl: ImageNetworkName.rootImages +
                                widget.movies[index].image!,
                            height: 265.h,
                            cacheKey: "${widget.movies[index].image}1",
                            memCacheHeight: 600,
                            maxHeightDiskCache: 600,
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
                                child: CircularProgressIndicator(
                                    color: MyColors.deepOrange),
                              );
                            },
                            fit: BoxFit.cover)),
                    Positioned(
                        top: 220.h,
                        child: IconFavoriteButtonWidget(
                          size: 25,
                          paddingSize: 12,
                          movieHive: MovieHive(
                              image: widget.movies[index].image,
                              id: widget.movies[index].id,
                              rating: widget.movies[index].rating,
                              productionData:
                                  widget.movies[index].productionData),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30.w, bottom: 5.h),
              child: RatingBarIndicator(
                rating: widget.movies[index].rating / 2,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 15.0,
                unratedColor: Colors.grey,
                direction: Axis.horizontal,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30.w),
              child: AutoSizeText(
                widget.movies[index].title!,
                maxLines: 2,
                style: TextStyle(
                    color: MyColors.white,
                    fontSize: 17.sp,
                    fontFamily: MyFont.titleFont),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    );
  }
}
