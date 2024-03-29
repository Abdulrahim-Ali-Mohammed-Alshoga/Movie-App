import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/color_manager.dart';
import 'package:movies/constants/image_asset_name.dart';
import '../../constants/font.dart';
import '../../constants/screen_name.dart';
import '../widgets/page_view_on_board.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true, i) : _indicator(false, i));
    }
    return list;
  }

  Widget _indicator(bool isActive, int numPages) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _pageController.jumpToPage(numPages);
          _currentPage = numPages;
        });
      },
      child: Container(
        color: ColorManager.black,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: 11.0,

          width: isActive ? 22.0 : 11.0,
          decoration: BoxDecoration(
              color: isActive ? ColorManager.deepOrange : ColorManager.grey,
              borderRadius: BorderRadius.all(const Radius.circular(12).r)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 100.h, left: 20.w, right: 20.w,bottom: 20.h),
        child: Column(
          children: [
            SizedBox(
              height: 570.h,
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  PageViewOnBoard(
                      image: ImageAssetName.onBoardImageOne,
                      textOne: "In love with movies ! ",
                      textTow:
                          "Get ready to try a new experience of cinema movies reservation"),
                  PageViewOnBoard(
                    image: ImageAssetName.onBoardImageTwo,
                    textOne: "Get in action",
                    textTow:
                        "Select you movie , book your chair , get ready to go",
                  ),
                  PageViewOnBoard(
                      image: ImageAssetName.onBoardImageThree,
                      textOne: "Now you're good to go ! ",
                      textTow:
                          "Just show your ticket to the doorman in the cinema place and get in , no more reservation lines"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            _currentPage != _numPages - 1
                ? Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: MyFont.mainFont,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.color,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(
                              width: 10.0.w,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color:
                                  Theme.of(context).textTheme.headline2?.color,
                              size: 22,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shadowColor: ColorManager.deepOrange,
                          backgroundColor: ColorManager.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10).r),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width - 50.w, 60.h),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ScreenName.personalInformationScreen);
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: ColorManager.white,
                              fontSize: 25.sp,
                              fontFamily: MyFont.mainFont),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
