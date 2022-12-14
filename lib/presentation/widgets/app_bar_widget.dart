import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movies/business_logic/cubit/auth_cubit.dart';
import 'package:movies/constants/name_page.dart';

import '../../constants/hive_name.dart';
import '../../constants/mycolor.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  Widget nameAppBar;

  AppBarWidget({
    Key? key,
    required this.nameAppBar,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool isSearch = false;
  var box = Hive.box(authDb);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, searchMoviesScreen);
        }, icon: Icon(Icons.search,)),
        box.get(typeAuthTable,defaultValue:false)
            ? IconButton(
                onPressed: () {
                  //  BlocProvider.of<SystemCubit>(context).changTheme();
                },
                icon: Icon(
                  Icons.person,
                 // size: 25.w,
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, personalInformationScreen);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Image.asset(
                      width: 30.w, height: 30.h, "assets/images/log_in.png"),
                ),
              ),

      ],
      title: widget.nameAppBar,
    );
  }
}
