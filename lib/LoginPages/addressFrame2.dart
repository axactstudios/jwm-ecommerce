import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:jwm2/Classes/Constants.dart';
import 'package:jwm2/Classes/User.dart';
import 'package:flutter/material.dart';

import 'address2.dart';

// ignore: must_be_immutable
class AddressFrame2 extends StatefulWidget {
  User userData = User();
  AddressFrame2({Key key, this.userData}) : super(key: key);

  @override
  _AddressFrame2State createState() => _AddressFrame2State();
}

class _AddressFrame2State extends State<AddressFrame2> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kWhiteColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Enter Primary Address',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontSize: 30.0, color: kTextColor),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 360,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: PageView(
                      controller: pageController,
                      children: <Widget>[
                        Address2(userData: widget.userData),
                      ],
                    ),
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
