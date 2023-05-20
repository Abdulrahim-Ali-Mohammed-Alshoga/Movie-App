import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/widgets/home/shimmer/page_view_widget_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import '../title_wdget_home.dart';
import 'list_view_widget_shimmer.dart';

class HomeWidgetShimmer extends StatefulWidget {
  const HomeWidgetShimmer({Key? key}) : super(key: key);

  @override
  State<HomeWidgetShimmer> createState() => _HomeWidgetShimmerState();
}

class _HomeWidgetShimmerState extends State<HomeWidgetShimmer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
                padding: EdgeInsets.only(right: 30.w),
                child: TextWidgetHome(
                  text: "Recent Movies",
                )),
          ),
          SizedBox(
            height: 430.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: const PageViewWidgetShimmer(),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.w, right: 5.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [TextWidgetHome(text: "Action")])),
          Container(
              height: 180,
              margin: EdgeInsets.only(top: 10.h, bottom: 15.h,left: 15),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: Colors.grey.withOpacity(.22)),
              child: const ListViewWidgetShimmer()),
        ],
      ),
    );
  }
}
