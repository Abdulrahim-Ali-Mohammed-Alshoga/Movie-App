import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movies/constants/screen_name.dart';
import '../../constants/arguments.dart';
import '../../constants/color_manager.dart';
import '../../constants/font.dart';
import '../../constants/hive_name.dart';
import '../widgets/text_form_field_widget.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({Key? key}) : super(key: key);

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool isPassword = true;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  var box = Hive.box(AuthHiveDB.authDB);

  Future<void> singInFill() async {
    if (globalKey.currentState!.validate()) {
      final navigator = Navigator.of(context);
      await box.put(AuthHiveDB.isAuthTable, true);
      box.put(AuthHiveDB.isSkip, false);
      globalKey.currentState!.save();
      navigator.pushNamedAndRemoveUntil(
          ScreenName.navigationBarScreen, (route) => false,
          arguments: NavigationBarArgument(isSkip: false));

      // Navigator.pushNamed(context, signUpScreen, arguments: {
      //   'name': name.text,
      //   'phoneNumber': phoneNumber.text,
      //   'address': address.text,
      //   'image': image
      // });
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        autovalidateMode: _autoValidateMode,
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 50.h, right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Cinema",
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontFamily: MyFont.mainFont,
                          color: ColorManager.white)),
                  TextSpan(
                      text: "Batool",
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontFamily: MyFont.mainFont,
                          color: ColorManager.deepOrange)),
                ])),
                SizedBox(height: 50.h),
                Text(
                  "Hello Again !",
                  style: TextStyle(
                      color: ColorManager.white,
                      fontFamily: MyFont.titleFont,
                      fontSize: 25.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Enter your E-mail & password to find out what's new",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: MyFont.mainFont,
                      color: ColorManager.grey),
                ),
                SizedBox(height: 60.h),
                TextFormFieldWidget(
                    controller: controllerEmail,
                    hintText: "Emile",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Emile cannot be empty';
                      } else if (!value.contains("@") ||
                          !value.contains(".com")) {
                        return 'This is not Email';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress),
                SizedBox(height: 20.h),
                TextFormFieldWidget(
                    controller: controllerPassword,
                    hintText: "Password",
                    obscureText: isPassword ? true : false,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        child: Icon(
                          isPassword ? Icons.visibility : Icons.visibility_off,
                          // size: 20,
                          color: ColorManager.white,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This is not  a valid Password';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: RichText(
                      text: TextSpan(children: <WidgetSpan>[
                    WidgetSpan(
                        child: Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 14.sp,
                        fontFamily: MyFont.mainFont,
                      ),
                    )),
                    WidgetSpan(
                        child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("SignUp",
                          style: TextStyle(
                            color: ColorManager.deepOrange,
                            fontSize: 14.sp,
                            fontFamily: MyFont.mainFont,
                          )),
                    )),
                  ])),
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
                            backgroundColor: ColorManager.deepOrange),
                        onPressed: () {
                          singInFill();
                        },
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: MyFont.mainFont,
                                color: ColorManager.white),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
