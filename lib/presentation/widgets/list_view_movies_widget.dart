import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/constants/name_page.dart';

import '../../data/models/movie.dart';
import 'list_movie_title_widget.dart';

class ListViewMoviesWidget extends StatelessWidget {
  ListViewMoviesWidget({Key? key, required this.movies}) : super(key: key);
  List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
        color: Colors.grey.withOpacity(.22)
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length > 7 ? 7 : movies.length,
        itemBuilder: (BuildContext context, index) {
          var isLastMovie = index == (movies.length > 7 ? 7 : movies.length) - 1
              ? true
              : false;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListMovieTitleWidget(
                movie: movies[index],
              ),
              isLastMovie
                  ? GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, scandScreen);
                },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: MyColors.white.withOpacity(.5), width: 1),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                          color: MyColors.white,
                        ),
                      ),
                  )
                  : SizedBox(
                      height: 0.1.h,
                    )
            ],
          );
        },
      ),
    );
  }
}
