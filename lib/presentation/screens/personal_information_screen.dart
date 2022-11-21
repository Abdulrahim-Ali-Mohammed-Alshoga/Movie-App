import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/mycolor.dart';
import 'package:movies/presentation/widgets/text_form_field_widget.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  Future<void> personalInfoFill() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();

      // Navigator.pushNamed(context, signUpScreen, arguments: {
      //   'name': name.text,
      //   'phoneNumber': phoneNumber.text,
      //   'address': address.text,
      //   'image': image
      // });
    }
    else {
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
                      color:MyColors.white),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Let's know you better , this basic information is used to improve youre experience",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: MyFont.mainFont,
                      color: Colors.grey),
                ),
                SizedBox(height: 60.h),
                TextFormFieldWidget(controller: controllerName,
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
                TextFormFieldWidget(controller: controllerPhoneNumber,
                    hintText: "Phone Number",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This is not  a valid phone number';
                      }
                      else if(value.length!=9){
                        return 'phone number consist of 9 digits';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone),
                SizedBox(height: 20.h),
                TextFormFieldWidget(controller: controllerAddress,
                    hintText: "Address",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address cannot be empty';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  height: 60.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange),
                        onPressed: () {
                          personalInfoFill();
                        },
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: MyFont.mainFont,
                                color:MyColors.white),
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
