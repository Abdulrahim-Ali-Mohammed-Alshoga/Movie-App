import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movies/business_logic/cubit/auth_cubit.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/constants/name_page.dart';
import 'package:movies/presentation/widgets/text_form_field_widget.dart';

import '../../constants/hive_name.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool isPassword = true;
  var box = Hive.box(authDb);
  Future<void> personalInfoFill() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      await box.put(authTable, true);
      await  box.put(typeAuthTable, false);

      Navigator.pushNamedAndRemoveUntil(
          context, splashScreen, (route) => false);

      // Navigator.pushNamed(context, signUpScreen, arguments: {
      //   'name': name.text,
      //   'phoneNumber': phoneNumber.text,
      //   'address': address.text,
      //   'image': image
      // });
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        autovalidateMode: autoValidateMode,
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontFamily: MyFont.mainFont,
                      color: MyColors.white),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Let's know you better , this basic information is used to improve youre experience",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: MyFont.mainFont,
                      color: MyColors.grey),
                ),
                SizedBox(height: 60.h),
                TextFormFieldWidget(
                    controller: controllerName,
                    hintText: "Name",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This is not  a valid name';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name),
                SizedBox(height: 20.h),
                TextFormFieldWidget(
                    controller: controllerPassword,
                    hintText: "Password",
                    obscureText: isPassword ? true : false,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          print(55);
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        child: Icon(
                          isPassword ? Icons.visibility : Icons.visibility_off,
                          // size: 20,
                          color: MyColors.white,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This is not  a valid Password';
                      } else if (value.length <= 6) {
                        return 'Password consist of 6 digits or more';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text),
                SizedBox(height: 20.h),
                TextFormFieldWidget(
                    controller: controllerEmail,
                    hintText: "Email",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (!value.contains("@") ||
                          !value.contains(".com")) {
                        return 'This is not Email';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: <WidgetSpan>[
                      const WidgetSpan(
                          child: Text(
                        "Already have an account ! ",
                        style: TextStyle(
                          color: MyColors.white,
                          fontSize: 12,
                          fontFamily: MyFont.mainFont,
                        ),
                      )),
                      WidgetSpan(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, singInScreen);
                          //  Navigator.pushNamedAndRemoveUntil(context, singInScreen, (route) => false);
                        },
                        child: const Text(" SignIn",
                            style: TextStyle(
                              color: MyColors.deepOrange,
                              fontSize: 12,
                              fontFamily: MyFont.mainFont,
                            )),
                      )),
                    ])),
                    GestureDetector(
                      onTap: () {
                        box.put(authTable, true);
                        box.put(typeAuthTable, false);
                        Navigator.pushNamedAndRemoveUntil(
                            context, splashScreen, (route) => false);
                      },
                      child: Text(
                        style: TextStyle(
                          color: MyColors.white,
                          fontSize: 12.sp,
                          fontFamily: MyFont.mainFont,
                        ),
                        "Skip",
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 60.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.deepOrange),
                        onPressed: () {
                          personalInfoFill();
                        },
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: MyFont.mainFont,
                                color: MyColors.white),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
