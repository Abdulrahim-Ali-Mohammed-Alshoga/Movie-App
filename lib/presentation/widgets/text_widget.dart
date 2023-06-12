
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWidget extends StatelessWidget {
  TextWidget({Key? key,this.textAlign=TextAlign.start,this.typeFonts='Bitter',required this.color,required this.fontWeight,required this.size,required this.text}) : super(key: key);
  String text,typeFonts;
  Color color;
  double size;
  TextAlign textAlign;
  FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style:TextStyle( fontSize: size.sp,
            color: color,
            fontWeight: fontWeight));
  }

}