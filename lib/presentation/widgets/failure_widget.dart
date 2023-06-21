import 'package:flutter/material.dart';

import '../../constants/color_manager.dart';
class FailureWidget extends StatelessWidget {
   FailureWidget({Key? key, this.sizeIcon,required this.onPressed,this.colorIcon= ColorManager.white}) : super(key: key);
   VoidCallback onPressed;
  Color colorIcon;
  double? sizeIcon;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: IconButton(
            onPressed:onPressed,
            icon:  Icon(size: sizeIcon,Icons.refresh,color:colorIcon),
          )

    );
  }
}
