import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/widgets/app_bar_widget.dart';

import '../../constants/font.dart';
import '../../constants/mycolor.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(nameAppBar: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "Cinema",
              style: TextStyle(fontFamily: MyFont.mainFont,color: MyColors.white,fontSize: 30.sp)
            ),
            TextSpan(
                text: "Batool",
                style: TextStyle(fontFamily: MyFont.mainFont,color: MyColors.deepOrange,fontSize: 30.sp)
            ),
          ]
        ),
      )),
    );
  }
}
