import 'package:flutter/material.dart';
import '../../constants/color_manager.dart';
import '../../constants/font.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  Widget? suffixIcon;
  final bool obscureText;

  // final Function save;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final String? hintText;

  TextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.textInputAction,
      this.validator,
      required this.textInputType,
      this.suffixIcon,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      cursorColor: ColorManager.white,
      style:
          const TextStyle(color: ColorManager.white, fontFamily: MyFont.mainFont),
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        enabledBorder:  const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.white),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.redAccent),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.redAccent),
        ),
        hintStyle: const TextStyle(color: ColorManager.grey),
        hintText: hintText,
      ),
    );
  }
}
