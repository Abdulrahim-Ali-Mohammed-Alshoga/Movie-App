import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/data/models/movie.dart';
import '../../constants/arguments.dart';
import '../../constants/color_manager.dart';
import '../../constants/hive_name.dart';
import '../../constants/screen_name.dart';
import '../../data/models/hive/movie_hive.dart';
import 'cached_network_image_widget.dart';
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
                  color:  ColorManager.whiteDarkOpacity30,
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20).r,
                        child: CachedNetworkImageWidget(image: widget.movies[index].image,height: 265.h,)),
                    Positioned(
                        child: IconFavoriteButtonWidget(
                          size: 25,
                          paddingSize: 12,
                          movieHive: MovieHive(
                              image: widget.movies[index].image,
                              id: widget.movies[index].id!,
                              rating: widget.movies[index].rating!,
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
                rating: widget.movies[index].rating! / 2,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: ColorManager.amber,
                ),
                itemCount: 5,
                itemSize: 15.0,
                unratedColor: ColorManager.grey,
                direction: Axis.horizontal,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30.w),
              child: AutoSizeText(
                widget.movies[index].title!,
                maxLines: 2,
                style: TextStyle(
                    color: ColorManager.white,
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
