import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/color_manager.dart';
class BottomNavigationBarItemWidget extends StatelessWidget {
  final Function onPressed;
  final String label;
  final IconData icon;
  final bool isSelected;
  const BottomNavigationBarItemWidget(
      {Key? key,
        required this.onPressed,
        required this.label,
        required this.isSelected,
         required this.icon,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

     Color color= isSelected
        ? ColorManager.white
        :ColorManager.grey;
    return MaterialButton(
      minWidth: 40.w,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        onPressed();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(icon, size: 25.r, color: color),

          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
