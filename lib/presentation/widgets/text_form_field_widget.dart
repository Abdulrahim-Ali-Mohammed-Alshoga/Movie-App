import 'package:flutter/material.dart';

import '../../constants/font.dart';
import '../../constants/mycolor.dart';

class TextFormFieldWidget extends StatelessWidget {


  const TextFormFieldWidget(
      {Key? key, required this.controller,  required this.hintText,
        required this.textInputAction,required this.validator, required this.textInputType})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  // final Function save;
   final FormFieldValidator<String> validator;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,

      cursorColor: Colors.white,
      style: const TextStyle(
          color: MyColors.white, fontFamily: MyFont.mainFont),
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      decoration:  InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.grey, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        hintStyle: const TextStyle(color: MyColors.grey),
        hintText:hintText,
      ),
    )
    ;
  }
}
