import 'package:flutter/material.dart';

import 'Classes/Constants.dart';
import 'LoginPages/WelcomeScreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cabin',
        scaffoldBackgroundColor: kWhiteColor,
        primaryColor: kPrimaryColor,
        // ignore: deprecated_member_use
        textTheme: TextTheme(
          // ignore: deprecated_member_use
          headline: TextStyle(fontWeight: FontWeight.bold),
          button: TextStyle(fontWeight: FontWeight.bold),
          // ignore: deprecated_member_use
          title: TextStyle(fontWeight: FontWeight.bold),
          // ignore: deprecated_member_use
          body1: TextStyle(color: kTextColor),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
