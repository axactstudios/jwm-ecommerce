import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwm2/Classes/Constants.dart';
import 'package:jwm2/Classes/User.dart';
import 'package:jwm2/LoginPages/addressFrame2.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User userData = User();
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  FirebaseAuth mAuth = FirebaseAuth.instance;

  getUserData() async {
    FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;

    DatabaseReference userRef = dbRef.child('Users').child(uid);
    userRef.once().then((DataSnapshot snapshot) async {
      userData.name = await snapshot.value['Name'];
      print(userData.name);
      userData.phNo = await snapshot.value['phNo'];
      print(userData.phNo);
      userData.add1 = await snapshot.value['Add1'];
      print(userData.add1);
      userData.add2 = await snapshot.value['Add2'];
      print(userData.add2);
      userData.pin = await snapshot.value['Zip'];
      print(userData.pin);
      setState(() {
        print('Done');
      });
    });
  }

  @override
  void initState() {
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2629,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(250),
                          bottomRight: Radius.circular(250)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 150,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'PROFILE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                fontFamily: 'Cabin',
                                letterSpacing: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.14,
                  ),
                  userData.name == null
                      ? SpinKitWave(
                          color: kPrimaryColor,
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 46.2),
                                child: Container(
                                  width: size.width * 0.9,
                                  decoration:
                                      BoxDecoration(color: kPrimaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                          color: kWhiteColor,
                                          size: 30,
                                        ),
                                        Text(
                                          userData.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: kWhiteColor,
                                                  fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 55),
                                child: Container(
                                  width: size.width * 0.9,
                                  decoration:
                                      BoxDecoration(color: kPrimaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          Icons.phone,
                                          color: kWhiteColor,
                                          size: 30,
                                        ),
                                        Text(
                                          userData.phNo,
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: kWhiteColor,
                                                  fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 46.2),
                                child: Container(
                                  width: size.width * 0.9,
                                  decoration:
                                      BoxDecoration(color: kPrimaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          Icons.home,
                                          color: kWhiteColor,
                                          size: 30,
                                        ),
                                        Text(
                                          userData.add1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: kWhiteColor,
                                                  fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 55),
                                child: Container(
                                  width: size.width * 0.9,
                                  decoration:
                                      BoxDecoration(color: kPrimaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_city,
                                          color: kWhiteColor,
                                          size: 30,
                                        ),
                                        Text(
                                          userData.add2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: kWhiteColor,
                                                  fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 46.2),
                                child: Container(
                                  width: size.width * 0.9,
                                  decoration:
                                      BoxDecoration(color: kPrimaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          color: kWhiteColor,
                                          size: 30,
                                        ),
                                        Text(
                                          userData.pin,
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(
                                                  color: kWhiteColor,
                                                  fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
