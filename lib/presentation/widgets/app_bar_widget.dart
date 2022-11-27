import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/business_logic/cubit/auth_cubit.dart';

import '../../constants/mycolor.dart';
class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  Widget nameAppBar;
  AppBarWidget(
      {Key? key,
        required this.nameAppBar,
        })
      : super(key: key);
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        BlocProvider.of<AuthCubit>(context).typeAuth?IconButton(
          onPressed: () {
            //  BlocProvider.of<SystemCubit>(context).changTheme();
          },
          icon: Icon(
            Icons.person,
            size: 30.w,
          ),
        )
        :Padding(
          padding:EdgeInsets.only(right: 10.w),
          child: Image.asset(width: 38.w,height: 38.h,"assets/images/log_in.png"),
        )

      ],
      title:widget.nameAppBar,

    );
  }
}
