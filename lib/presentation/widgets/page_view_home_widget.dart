import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/data/models/movie.dart';

class PageViewHomeWidget extends StatefulWidget {
  List<Movie> movies;
   PageViewHomeWidget({Key? key,required this.movies}) : super(key: key);

  @override
  State<PageViewHomeWidget> createState() => _PageViewHomeWidgetState();
}

class _PageViewHomeWidgetState extends State<PageViewHomeWidget> {
 final PageController _pageController = PageController(viewportFraction: .50);
int _currentPage = 0;
double width=180.w;
time(){
  Timer(const Duration(seconds: 2), () {setState((){
    width=0.0;
  }); });
}
@override
  void initState() {
    // TODO: implement initState
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
    return Container(
      height: 680.h,
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
          final double top = active ? 30.h : 70.h;
          return Column(

            children: [
AnimatedContainer(duration: Duration(seconds: 2),
curve: Curves.easeInOutCubicEmphasized,
  margin: EdgeInsets.only(top: top,bottom:30.h ,left: 30.w),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.r),
  ),
  child:
        ClipRRect(borderRadius:BorderRadius.circular(20),child:CachedNetworkImage(imageUrl: widget.movies[index].image,fit: BoxFit.cover)),

),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(widget.movies[index].title,style: TextStyle(
                  color: MyColors.white,
                  fontSize: 20.sp,
                  fontFamily: MyFont.titleFont
                ),),
              )
            ],
          );
        },

      ),
    );
  }
}


