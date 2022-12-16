import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/data/models/movie.dart';

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

  time() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        width = 0.0;
      });
    });
  }

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
    return SizedBox(
      height: 430.h,
      // color: Colors.deepOrange,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          bool active = index == _currentPage;
          print(widget.movies[index].rating.runtimeType);
          print(index);
          final double top = active ? 30.h : 70.h;
          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubicEmphasized,
                margin: EdgeInsets.only(top: top, bottom: 10.h, right: 30.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.black.withOpacity(.2),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                        imageUrl: widget.movies[index].image,
                        height: 265,
                        key: UniqueKey(),
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
                  itemSize: 15.0,unratedColor: Colors.grey,
                  direction: Axis.horizontal,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.w),
                child: AutoSizeText(
                  widget.movies[index].title,
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
      ),
    );
  }
}
