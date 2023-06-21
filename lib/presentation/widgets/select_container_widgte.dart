import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/color_manager.dart';
import 'package:movies/presentation/widgets/shimmer/shimmer_widget.dart';
import 'package:movies/presentation/widgets/text_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../business_logic/cubit/genre/genre_cubit.dart';
import '../../business_logic/cubit/genre/genre_state.dart';
import '../../business_logic/cubit/movies_by_genre/genre_movies_cubit.dart';
import '../../data/models/genre.dart';

class SelectContainerWidget extends StatefulWidget {
  const SelectContainerWidget({Key? key}) : super(key: key);

  @override
  State<SelectContainerWidget> createState() => _SelectContainerWidgetState();
}

class _SelectContainerWidgetState extends State<SelectContainerWidget> {
  late List<Genre> genres;
  int? select = 0;

  ScrollController controllerRow = ScrollController();
  PageStorageKey myKey = const PageStorageKey("testkey");
  final PageStorageBucket _bucket = PageStorageBucket();
  final itemScroll = ItemScrollController();

  Future<void> scrollToItem(int index, int timer) async {
    itemScroll.scrollTo(
        duration: Duration(milliseconds: timer),
        curve: Curves.easeInOutCubic,
        index: index,
        alignment: .36);
  }

  double gg(int lengthGenreName) {
    if (lengthGenreName <= 5) {
      return .4;
    }
    if (lengthGenreName == 7 || lengthGenreName == 6) {
      return .37;
    } else {
      return .35;
    }
  }

  @override
  Widget build(BuildContext context) {
    // _scaffoldKey = new GlobalObjectKey<ScaffoldState>(id);
    return SizedBox(
      height: 60.h,
      child: BlocConsumer<GenreCubit, GenreState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return ListView.builder(
              padding: EdgeInsets.only(
                  top: 13.h, bottom: 8.h, right: 8.w, left: 8.w),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return ShimmerWidget(
                  width: 120.w,
                  color: ColorManager.greyOpacity30,
                  circular: 8.r,
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                );
              },
            );
          } else if (state is GenreFailure) {
            return Container();
          }
          else{
            genres = BlocProvider.of<GenreCubit>(context).genre;
            select = BlocProvider.of<GenreCubit>(context).numberSelectGenre;
            return ScrollablePositionedList.builder(
              itemScrollController: itemScroll,
              padding: EdgeInsets.only(
                  top: 13.h, bottom: 8.h, right: 8.w, left: 8.w),
              itemCount: genres.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  //key: _MyKey(genres[index].id!+widget.uniqueKye),
                    onTap: () {
                      setState(() {
                        select = index;
                        BlocProvider.of<GenreCubit>(context)
                            .enterNumberSelectGenre(numberSelect: index);
                        BlocProvider.of<GenreMoviesCubit>(context)
                            .getGenreMovies(
                            select == 0 ? 0 : genres[index].id!);
                        scrollToItem(index, 500);
                        // Scrollable.ensureVisible(
                        //     _MyKey(genres[index].id!+widget.uniqueKye)
                        //         .currentContext!,
                        //
                        //     // duration for scrolling time
                        //     alignment: .5,
                        //     duration: const Duration(milliseconds: 250),
                        //     // 0 mean, scroll to the top, 0.5 mean, half
                        //     curve: Curves.easeInOutCubic);
                      });
                      //  print(_MyKey(BlocProvider.of<GenreCubit>(context).numberSelectGenre)
                      //      .currentContext);
                      //  print('kkkkkkkkkkkkkkkkkkkkkkkkk');
                      // print(_MyKey(BlocProvider.of<GenreCubit>(context).numberSelectGenre)
                      //      .value);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: index == select
                            ? ColorManager.deepOrange
                            : ColorManager.grey,
                        border: index == select
                            ? null
                            : Border.all(width: .5, color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                        // boxShadow: isSelect
                        //     ?R.shadow.shadow7
                        //     : null,
                      ),
                      child: TextWidget(
                          size: 17,
                          color: index == select
                              ? ColorManager.white
                              : ColorManager.black,
                          fontWeight: index == select
                              ? FontWeight.bold
                              : FontWeight.normal,
                          text: genres[index].name!),
                    )
                  // SelectContainerWidget(
                  //   isSelect: index == select ? true : false,
                  //   text:genres[index].name!,
                  //   edgeInsetsPadding:
                  //   EdgeInsets.symmetric(horizontal: 15.w),
                  //   edgeInsetsMargin: EdgeInsets.symmetric(horizontal: 6.w),
                  //   radiusSize: 8,
                  // ),
                );
              },
            );
          }
        },
        listener: (context, state) async {
          if (state is GenreSuccess) {
            BlocProvider.of<GenreMoviesCubit>(context).getGenreMovies(0);
          } else if (state is GenreFailure) {
            BlocProvider.of<GenreMoviesCubit>(context).getFailure();
          } else if (state is GenreChange) {
            scrollToItem(
                BlocProvider.of<GenreCubit>(context).numberSelectGenre, 100);
            print(BlocProvider.of<GenreCubit>(context).numberSelectGenre);
            // print(  GlobalObjectKey(
            //     BlocProvider.of<GenreCubit>(context).numberSelectGenre )
            //     .value);
            // Scrollable.ensureVisible(
            //     _MyKey(BlocProvider.of<GenreCubit>(context).numberSelectGenre+widget.uniqueKye)
            //         .currentContext!,
            //
            //     // duration for scrolling time
            //     alignment: .5,
            //     duration: const Duration(milliseconds: 1500),
            //     // 0 mean, scroll to the top, 0.5 mean, half
            //     curve: Curves.easeInOutCubic);

            // if(GlobalObjectKey(genreSelect.id!+
            //     widget.uniqueKye)
            //     .currentContext!=null){
            //
            // }
            // else{
            //
            //
            // }
          }
        },
      ),
    );
  }
}

class _MyKey extends GlobalObjectKey {
  const _MyKey(super.value);
}
//   DropdownButtonHideUnderline(
//
//   child: DropdownButton<Genre>(
//       iconEnabledColor: ColorManager.deepOrange,
//       value: select ?? genres[0],
//       alignment: Alignment.centerLeft,
//       dropdownColor: ColorManager.black,
//
//       items: genres
//           .map((e) => DropdownMenuItem(
//
//           value: e,
//           child: Text(
//             e.name!,
//             style: TextStyle(
//                 fontSize: 16.sp,
//                 fontFamily: MyFont.titleFont,
//                 color: ColorManager.deepOrange),
//           )))
//           .toList(),
//       onChanged: (selected) {
//         setState(() {
//           select = selected;
//           BlocProvider.of<GenreMoviesCubit>(context)
//               .getGenreMovies(selected!.name == 'All'
//               ? 0
//               : selected.id);
//         });
//       }),
// )
