import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  ShimmerWidget(
      {Key? key,
      this.color,
      this.margin,
      this.height = double.infinity,
      this.width = double.infinity,
      this.circular = 0})
      : super(key: key);
  double height, width, circular;
  EdgeInsetsGeometry? margin;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 3),
      highlightColor: Colors.grey,
      baseColor: const Color(0xfff0f0f0),
      child: Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(circular)),
      ),
    );
  }
}
