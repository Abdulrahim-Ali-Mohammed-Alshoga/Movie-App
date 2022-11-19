
import 'package:flutter/material.dart';

import '../../constants/font.dart';
import '../../constants/mycolor.dart';

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

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8.0,
      width: isActive ? 20.0 : 8.0,
      decoration: BoxDecoration(
          color: isActive ? MyColors.green : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20,bottom: 40),
        child: Column(

          children: [
            SizedBox(
              height: 570,
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/1.png'),
                          height: 300,
                          width: 300,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "In love with movies ! ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.titleFont,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Get ready to try a new experience of cinema movies reservation",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.mainFont,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/2.png'),
                          height: 300,
                          width: 300,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Get in action",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.titleFont,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Select you movie , book your chair , get ready to go",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.mainFont,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/3.png'),
                          height: 300,
                          width: 300,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Now you're good to go ! ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.titleFont,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Just show your ticket to the doorman in the cinema place and get in , no more reservation lines",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.mainFont,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.color,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
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
                            fontSize: 20),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context)
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
                :  Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Already have an account ! ",
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.headline2?.color,
                                  fontFamily: MyFont.mainFont,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(context, signInScreen);
                                },
                                child: const Text("SignIn",
                                    style: TextStyle(
                                      color:MyColors.green,
                                      fontFamily: MyFont.mainFont,
                                    )),
                              )
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shadowColor: MyColors.green,
                            backgroundColor: MyColors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fixedSize:
                            Size(MediaQuery.of(context).size.width - 50, 60),
                          ),
                          onPressed: () {
                            //    Navigator.pushNamed(context, personalInfo),
                          } ,
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: MyFont.mainFont),
                          ),
                        ),
                      ],
                  ),
                )
          ],
        ),
      ),
      // bottomSheet: _currentPage == _numPages - 1
      //     ?
      //     : const Text(''),
    );
  }
}
