import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/data/models/movie.dart';
import 'package:movies/presentation/widgets/stack_details_moive_widget.dart';

import '../../constants/arguments.dart';
import '../../constants/font.dart';
import '../../constants/mycolor.dart';

class DetailsMovieScreen extends StatefulWidget {
  DetailsMovieScreen({Key? key, required this.detailsMovie}) : super(key: key);
  DetailsMovie detailsMovie;

  @override
  State<DetailsMovieScreen> createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  late Movie movie;
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    movie = widget.detailsMovie.detailsMovie;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StackDetailsMovieWidget(movie: movie),
            Padding(
              padding: const EdgeInsets.only(top: 140, left: 20),
              child: Row(
                children: [
                  Text(
                    "Rating : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: MyColors.white,
                        fontFamily: MyFont.titleFont,
                        fontSize: 15.sp),
                  ),
                  RatingBarIndicator(
                    rating: movie.rating / 2,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemPadding: EdgeInsets.only(bottom: 0),
                    itemCount: 5,
                    itemSize: 20.0,
                    unratedColor: Colors.grey,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: movie.rating.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: MyFont.mainFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp),
                      ),
                      TextSpan(
                        text: "/10",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.sp,
                            fontFamily: MyFont.mainFont),
                      )
                    ]),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "Votes : ",
                      style: TextStyle(
                          color: MyColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    ),
                    TextSpan(
                      text: "${movie.vote} vote",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.sp,
                          fontFamily: MyFont.mainFont),
                    )
                  ]),
                )),
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 20.w),
              child: Text(
                "Story line :",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: MyColors.white,
                    fontFamily: MyFont.titleFont,
                    fontSize: 15.sp),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Text(
                movie.description,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.sp,
                    fontFamily: MyFont.mainFont),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
