import 'package:flutter/material.dart';
import 'package:movies/constants/font.dart';
import 'package:movies/constants/mycolor.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.only( left: 20,top: 40,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Information",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: MyFont.mainFont,
                    color: Theme.of(context).textTheme.headline2?.color),
              ),
              SizedBox(height: 10),
              Text(
                "Let's know you better , this basic information is used to improve youre experience",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: MyFont.mainFont,
                    color:Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
