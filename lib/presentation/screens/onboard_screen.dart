import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/auth_cubit.dart';

import '../../business_logic/cubit/auth_state.dart';
import '../../constants/font.dart';
import '../../constants/mycolor.dart';
import '../../constants/name_page.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int stat = 0;

  Widget pageViewOnBoard(String image, String textOne, String textTow) {
    return Padding(
      padding:  const EdgeInsets.all(40.0).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(image),
            height: 300.h,
            width: 300.w,
          ),
           SizedBox(
            height: 30.h,
          ),
          Text(
            textOne,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.titleFont,
                color: Theme
                    .of(context)
                    .textTheme
                    .headline2
                    ?.color,
                fontSize: 20.sp),
          ),
           SizedBox(
            height: 15.h,
          ),
          Text(
            textTow,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.mainFont,
                color: Theme
                    .of(context)
                    .textTheme
                    .headline2
                    ?.color,
                fontSize: 18.sp),
          ),
        ],
      ),
    )
    ;
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true,i) : _indicator(false,i));
    }
    return list;
  }

  Widget _indicator(bool isActive,int numPages) {
    return GestureDetector(

      onTap: (){
        setState(() {
          _pageController.jumpToPage(numPages);
          _currentPage=numPages;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 11.0,
        width: isActive ? 22.0 : 11.0,
        decoration: BoxDecoration(
            color: isActive ? MyColors.deepOrange : MyColors.grey,
            borderRadius:  BorderRadius.all(const Radius.circular(12).r)),
      ),
    );
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((value) => FlutterNativeSplash.remove());
  }
  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthCubit,AuthState>(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        body: Padding(
          padding:  EdgeInsets.only(
              top: 100.h, left: 20.w, right: 20.w),
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
                    pageViewOnBoard(
                        'assets/images/1.png', "In love with movies ! ",
                        "Get ready to try a new experience of cinema movies reservation"),
                    pageViewOnBoard(
                        'assets/images/2.png',"Get in action",
                      "Select you movie , book your chair , get ready to go",),
                    pageViewOnBoard(
                      'assets/images/3.png',"Now you're good to go ! ",
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
                              color: Theme
                                  .of(context)
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
                          color: Theme
                              .of(context)
                              .textTheme
                              .headline2
                              ?.color,
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
                      shadowColor: MyColors.deepOrange,
                      backgroundColor: MyColors.deepOrange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10).r),
                      fixedSize:
                      Size(MediaQuery
                          .of(context)
                          .size
                          .width - 50.w, 60.h
                      ),
                    ),
                    onPressed: () {
                          Navigator.pushNamed(context, personalInformationScreen);
                    },
                    child:  Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.sp,
                          fontFamily: MyFont.mainFont),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      listener: (context, state) {
        if(state is AuthSuccess){
          Navigator.pushNamedAndRemoveUntil(context, homeScreen, (route) => false);
        }
      },
    );
  }
}
