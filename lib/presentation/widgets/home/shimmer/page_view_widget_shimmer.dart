import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/color_manager.dart';
import 'package:movies/presentation/widgets/shimmer_widget.dart';

class PageViewWidgetShimmer extends StatefulWidget {
  const PageViewWidgetShimmer({Key? key}) : super(key: key);

  @override
  State<PageViewWidgetShimmer> createState() => _PageViewWidgetShimmerState();
}

class _PageViewWidgetShimmerState extends State<PageViewWidgetShimmer> {
  final PageController _pageController = PageController(viewportFraction: .50);
  int _currentPage = 0;

  double width = 180.w;

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
      itemCount: 10,
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
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOutCubicEmphasized,
              margin: EdgeInsets.only(top: top, bottom: 10.h, right: 30.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: ColorManager.blackOpacity20,
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ShimmerWidget(
                      circular: 20.r,
                      height: 265.h,
                      color: ColorManager.greyOpacity40),
                  const Positioned(
                    bottom: 15,
                    right: 15,
                    child: Icon(
                        color: ColorManager.red, size: 25, Icons.favorite_border),
                  ),
                ],
              ),
            ),
            ShimmerWidget(
              color: ColorManager.greyOpacity40,
              margin: EdgeInsets.only(top: 5, right: 30.w),
              height: 10,
              circular: 4,
            ),
            ShimmerWidget(
              margin: EdgeInsets.only(right: 30.w, top: 10),
              color: ColorManager.greyOpacity40,
              height: 10,
              circular: 4,
            ),
          ],
        );
      },
    );
  }
}
