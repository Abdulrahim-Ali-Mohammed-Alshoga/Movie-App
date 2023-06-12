import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/color_manager.dart';
import '../../../business_logic/cubit/search_movies/search_movie_cubit.dart';
import '../../../constants/font.dart';
class AppBarSearchWidget extends StatefulWidget implements PreferredSizeWidget {
   AppBarSearchWidget({Key? key,required this.controller}) : super(key: key);
  TextEditingController controller;
  @override
  State<AppBarSearchWidget> createState() => _AppBarSearchWidgetState();
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _AppBarSearchWidgetState extends State<AppBarSearchWidget> {
  bool isClean = true;
  FocusNode focusNode = FocusNode();
  bool isSearch = true;
  //
  getMovie(){


     BlocProvider.of<SearchMovieCubit>(context).getSearchMovie(nameMovie: widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      elevation: 10,
      actions: [
        if (!isClean)
          IconButton(
              splashRadius: 1,
              onPressed: () {
                // widget.actionSearch(widget.controller.text);
                widget.controller.clear();
                setState(() {
                  isClean = true;
                  isSearch = true;
                  FocusScope.of(context).requestFocus(focusNode);
                });
              },
              icon: Icon(
                Icons.clear,
              )),
        if (isSearch)
          IconButton(
              splashRadius: 1,
              onPressed: () {
                if (widget.controller.text.isNotEmpty) {
                  getMovie();
                  focusNode.unfocus();
                  setState(() {
                    isSearch = false;
                  });
                }
              },
              icon: const Icon(
                Icons.search,
                color: ColorManager.white,
              )),
      ],
      title: TextFormField(
        onTap: () {
          if (!isSearch) {
            isSearch = true;
          }
        },
        onChanged: (v) {
          if (isClean && widget.controller.text.isNotEmpty) {
            setState(() {
              print(666622);
              isClean = false;

            });
          } else if (widget.controller.text.isEmpty) {
            setState(() {
              isClean = true;
            });
          }
        },
        keyboardType: TextInputType.text,
        cursorColor: ColorManager.white,
        style: TextStyle(
            color: ColorManager.white,
            fontFamily: MyFont.titleFont,
            fontSize: 16.sp),
        controller: widget.controller,
        autofocus: isSearch ? true : false,
        focusNode: focusNode,
        maxLines: 1,
        cursorHeight: 24,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (s) {
          getMovie();
          setState(() {
            isSearch = false;
          });
          print("object");
        },
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: ColorManager.grey),
          hintText: "Search",
        ),
      ),
    );
  }
}
